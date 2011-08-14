module ApplicationHelper
  def outgoing_menssage
    if notice
      raw "<h4 class='alert_success'>#{notice}</h4>"
    end
  end


end
