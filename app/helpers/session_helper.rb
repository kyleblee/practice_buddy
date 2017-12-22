module SessionHelper

  def home_list_link(user, object)
    if object.user
      link_to object.name, "/users/#{user.id}/#{object.class.name.underscore.pluralize}/#{object.id}"
    else
      link_to object.name, "/#{object.class.name.underscore.pluralize}/#{object.id}"
    end
  end
end
