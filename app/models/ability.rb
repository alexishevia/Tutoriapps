class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :read, Group do |group| user.groups.include? group; end
      if user.admin?
          can :manage, Group
      end
    end
  end
end
