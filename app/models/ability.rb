class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    # Post abilities
    can :manage, Post, author_id: user.id
    can :manage, Post, author: { role: 'admin' }
    can :manage, Comment, user_id: user.id
    can :manage, Comment, user: { role: 'admin' }
  end
end
