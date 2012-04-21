class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :read, Group, :id => user.group_ids
    end
    if user.admin?
        can :create, Group
    end
  end
end
