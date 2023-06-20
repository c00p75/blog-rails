# Helper methods that help organize view logic
module UsersPostsHelper
  # Helper to update comments and likes counter
  def update_comments_and_likes_counter(post)
    Comment.update_comments_counter(post)
    Like.update_likes_counter(post)
  end

  # Helper to update post counter
  def update_posts_counter(user)
    Post.update_posts_counter(user)
  end

  # Helper to generate users list in users/index.html.erb
  def users_list(users)
    content_tag(:ul) do
      users.map do |user|
        update_posts_counter(user)
        render partial: 'users/user_card', locals: { user: }
      end.join.html_safe
    end
  end

  # Helper to display user name and generate link to a user if current path does not lead to user
  def user_link(user)
    current_page?(user_path(user)) ? user.name : link_to(user.name, user)
  end

  # Helper to generate list of posts. Arguments for partial can be post_comments or user_post.
  def posts_list(posts, partial)
    content_tag(:ul) do
      posts.map do |post|
        update_comments_and_likes_counter(post)
        render partial:, locals: { post: }
      end.join.html_safe
    end
  end

  # Helper to display post title and generate link to a post if current path does not lead to post
  def post_link(post)
    if current_page?(user_post_path(post.author_id,
                                    post))
      post.title
    else
      link_to(post.title, user_post_path(post.author_id, post))
    end
  end

  # Helper to list comments belonging to a post.
  # Loads most recent 5 posts for user_posts path
  # Loads all comments for post_path
  def comments_list(post)
    comments = current_page?(user_posts_path) ? Post.recent_comments(post) : @post.comments
    comments.map { |comment| render partial: 'posts/comment', locals: { comment: } }.join.html_safe
  end
end

# Show post author on post route
def show_post_author(user, post)
  return unless current_page?(user_post_path(user.id, post))

  content_tag(:span, class: 'author') { ' by '.html_safe + user_link(user) }
end
