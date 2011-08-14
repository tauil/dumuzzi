class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init, :authorize
  
  def init
    @authentications = current_user.authentications if current_user
  end
  
  def authorize
    controllers = %w(domains hosts hosts_services protocols queueds services state_changes)
    unless user_signed_in?
      controllers.each do |controller|    
        if params[:controller] == controller
          redirect_to "/"
        end
      end
    end
  end
  
end
