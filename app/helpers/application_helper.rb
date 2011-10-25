module ApplicationHelper
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
  
end
