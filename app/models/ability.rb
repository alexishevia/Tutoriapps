class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :create, Feedback
      can :read, Group do |group| user.groups.include? group; end
      can [:read, :create], [Post, Book] do |post|
        if post.group
          post.group.members.include? user
        else
          true
        end
      end

      if user.admin?
        can :manage, :all
      end
    end
  end
end
