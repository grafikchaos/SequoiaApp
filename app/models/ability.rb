class Ability
  include CanCan::Ability

  def initialize(user)

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

      # Entities
      can :manage, Entity

      # Projects
      can :destroy, Project do |project|
        access = true
        project.entities.each { |ent| access = false if cannot?(:destroy, ent) }
        access
      end

      # Own user account
      can :update, User, :id => user.id
      cannot :assign_roles, User
      cannot :assign_owner_role, User
    end

    # ADMIN
    if user.has_role? :admin
      can :manage, :all
      can :assign_roles, User
      cannot [:update, :destroy], User do |usr|
        usr.has_role? :owner
      end
      cannot :assign_owner_role, User
    end

    # disable access to Entities if the Entity_Roles doesn't have access to it 
    cannot [:read, :update, :destroy], Entity do |entity|
      intersection = entity.roles & user.roles
      intersection.empty?
    end
    
    # OWNER
    if user.has_role? :owner
      can :manage, :all
      can :assign_roles, User
      can :assign_owner_role, User
    end
 
    # User-wide abilities
    cannot [:update, :destroy], Role, :is_system => true
    cannot :destroy, User, :id => user.id
 
  end

end
