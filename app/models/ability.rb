class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :read, Group do |group| user.groups.include? group; end
      can :create, Post do |post|
        if post.group
          post.group.members.includ? user
        else
          true
        end
      end

      if user.admin?
          can :manage, [Group, Enrollment]
      end
    end
  end
end
