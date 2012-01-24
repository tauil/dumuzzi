class UsersController < ApplicationController
  before_filter :init, :only => [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.published == true
    @user.enabled = true
    @user.published_at = Time.now
    @user.can_login = true
      
    if @user.save
      flash[:notice] = I18n.t :successfully_created
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @authentications = @user.authentications if current_user
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = I18n.t :successfully_updated
      redirect_to root_url
    else
      render :edit
    end
  end

  protected
  def init
    @user = User.where(:id => params[:id]).first
  end

end
