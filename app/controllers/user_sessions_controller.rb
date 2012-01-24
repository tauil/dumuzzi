class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = I18n.t :successfully_created_user_session
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = I18n.t :successfully_destroyed_user_session
    redirect_to root_url
  end
end
