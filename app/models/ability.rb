class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
        can :create, Group
    end
  end
end
