module UsersPostsHelper

  def users_list(users)
    content_tag(:ul) do
      users.map { |user| render partial: 'users/user_card', locals: { user: user } }.join.html_safe
    end
  end

  def user_link(user)
    current_page?(user_path(user)) ? user.name : link_to(user.name, user)
  end

  def posts_list(posts)
    content_tag(:ul) do
      posts.map { |post| render partial: "users/user_post", locals: { post: post } }.join.html_safe
    end
  end

  def post_link(post)
    current_page?(user_posts_path(post)) ? post.title : link_to(post.title, user_post_path(post.author_id, post))
  end
end
