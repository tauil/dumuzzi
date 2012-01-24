module ApplicationHelper
  def avatar_url(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=100"
    end
  end    
  def outgoing_menssage
    if notice
      raw "<h4 class='alert_success'>#{notice}</h4>"
    end
  end

  # show_icon(object.enabled, "enabled", "disabled")
  def show_icon(object, enabled, disabled)
    alt = (object)? I18n.t(:"#{enabled}") : I18n.t(:"#{disabled}")
    return image_tag(object.to_s + '.png', {:alt => alt, :title => alt})
  end
  
  def outgoing_menssage
    if notice
      raw "<h4 class='alert_success'>#{notice}</h4>"
    elsif alert
      raw "<h4 class='alert_error'>#{alert}</h4>"
    end
  end
  
end
