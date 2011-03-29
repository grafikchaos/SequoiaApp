class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= User.new # guest user (not logged in)

    # Staff
    if user.role? :staff
      can [:read, :create, :update], [Client, Project]
      # can :destroy, Project # only if the project has entities with clearance levels less than or equal to the User's clearance
      can :manage, EntityRow

      # Favorites
      can :create, Favorite
      can [:read, :update, :destroy], Favorite do |favorite|
        favorite.user_id == user.id
      end

      # Projects
      can :destroy, Project do |project|
        access = true
        project.entities.each { |ent| access = false if ent.clearance < user.clearance}
        access
      end

      # Entities
      can [:read, :update, :destroy], Entity, :clearance => (user.clearance..3)
      can :create, Entity
    end

    # Manager inherits abilities from Staff + ability to manage users (:read, :create, :update but no :delete)
    if user.role? :manager
      can :manage, User
      cannot :destroy, User
    end

    # ADMIN - MANAGES ALL
    if user.role? :admin
      can :manage, :all
      cannot :destroy, User do |usr|
        usr == user
      end
    end
 
  end

end
