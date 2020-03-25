module ApplicationHelper
  def image_set(user)
    user.image? ? user.image.url : 'default.png'
  end
end
