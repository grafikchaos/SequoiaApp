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
    if user.has_role? :staff
      can [:read, :create, :update], [Client, Project]
      can :manage, EntityRow

      # Favorites
      can :create, Favorite
      can [:read, :update, :destroy], Favorite do |favorite|
        favorite.user_id == user.id
      end

      # TODO: DEPRECATED Projects 
      can :destroy, Project do |project|
        access = true
        project.entities.each { |ent| access = false if ent.clearance < user.clearance}
        access
      end

      # Entities
      can [:read, :update, :destroy], Entity
      can :create, Entity

      # Own user account
      can :update, User, :id => user.id
      cannot :assign_roles, User
      cannot :assign_owner_role, User
    end

    # TODO: DEPRECATED ADMIN - MANAGES ALL
    if user.has_role? :admin
      can :manage, :all
      can :assign_roles, User
      cannot [:update, :destroy], User do |usr|
        usr.has_role? :owner
      end
      cannot :assign_owner_role, User
    end

    # disable access to Entities if the Entity_Roles doesn't have access to it 
    cannot :read, Entity do |entity|
      intersection = entity.roles & user.roles
      intersection.empty?
    end
    
    # User-wide abilities
    cannot [:update, :destroy], Role, :is_system => true
    cannot :destroy, User, :id => user.id
    
    # OWNER
    if user.has_role? :owner
      can :manage, :all
      can :assign_roles, User
      can :assign_owner_role, User
    end
 
 
  end

end
