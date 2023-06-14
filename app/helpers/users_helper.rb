module UsersHelper
  def users_list(users)
    content_tag(:ul) do
      users.map { |user| content_tag(:li, user.name, class: "card") }.join.html_safe
    end
  end
end