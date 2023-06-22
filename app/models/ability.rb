class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    # Post abilities
    can :destroy, Post, author_id: user.id
    can :destroy, Post, author: { role: 'admin' }
    can :destroy, Comment, user_id: user.id
    can :destroy, Comment, user: { role: 'admin' }
  end
end
