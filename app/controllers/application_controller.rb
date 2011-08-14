class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init
  
  def init
    @authentications = current_user.authentications if current_user
  end
end
