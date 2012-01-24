class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init, :authorize
  helper_method :current_user, :require_user
  
  def init
    @authentications = current_user.authentications if current_user
  end
  
  def authorize
    controllers = %w(domains hosts hosts_services protocols queueds services state_changes)
    unless current_user_session
      controllers.each do |controller|    
        if params[:controller] == controller
          redirect_to "/"
        end
      end
    end
  end

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      flash[:notice] = I18n.t :you_must_be_logged
      redirect_to signin_path
      return false
    end
  end
  
end
