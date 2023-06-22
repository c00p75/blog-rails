class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    # Post abilities
    can :destroy, Post, user_id: user.id
    can :destroy, Post, user: { role: 'admin' }

    # Comment abilities
    can :destroy, Comment, user_id: user.id
    can :destroy, Comment, user: { role: 'admin' }
  end
end