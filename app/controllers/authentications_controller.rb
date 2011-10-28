class AuthenticationsController < ApplicationController
  before_filter :require_user, :only => [:destroy]
  
  def index
    @authentications = current_user.authentications if current_user
  end
  
  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.where(:provider => omniauth['provider'], :uid => omniauth['uid']).first
    if authentication
      flash[:notice] = "Signed in successfully."
      UserSession.create(authentication.user, true)
      redirect_to root_url
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      user = User.new
      user.apply_omniauth(omniauth)
      user.published = true
      user.enabled = true
      user.published_at = Time.now
      user.can_login = true
      
      if user.save
        flash[:notice] = "Signed in successfully."
        UserSession.create(user, true)
        redirect_to root_url
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_url
      end
    end
  end
  
  def failure
    flash[:notice] = "Sorry, You din't authorize"
    redirect_to root_url
  end

  def blank
    render :text => "Not Found", :status => 404
  end
  
  def destroy
    @authentication = current_user.authentications.where(:id => params[:id]).first
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
