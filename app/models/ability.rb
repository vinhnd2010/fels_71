class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
      cannot :update, Lesson
    else
      can [:update, :create], Lesson, user_id: user.id
      can [:create, :destroy], Relationship, follower_id: user.follower_id
  end
end
