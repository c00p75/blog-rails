class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    # Post abilities
    can :read, Post # Allow all users to view posts
    can :manage, Post, author_id: user.id # Gran all posts privillages to current user
    can :manage, Post, author: { role: 'admin' } # Gran all posts privillages to admin
    can :manage, Comment, user_id: user.id # Gran all comment privillages to current user
    can :manage, Comment, user: { role: 'admin' } # Gran all comment privillages to admin
  end
end
