class DomainsController < ApplicationController 
  before_filter :init, :only => [:show, :edit, :update, :destroy, :monitored]
  
  respond_to :html, :xml, :js, :json

  def index
    if current_user.is_admin
      @domains = Domain.order('created_at DESC')
    else
      @domains = Domain.where(:user_id => current_user.id).order('created_at DESC')
    end
    
    respond_with @domains
  end
    
  def show
    @hosts = Host.where(:domain_id => @domain.id, :is_domain_host => false).order('created_at ASC')
    
    respond_with @domain
  end

  def new
    @domain = Domain.new
    
    respond_with @domain
  end

  def edit
    respond_with @domain
  end

  def create
    @domain = Domain.new params[:domain]
    @domain.user_id = current_user.id
    @domain.monitor = false
    
    if @domain.save
      flash[:notice] = I18n.t :domain_created
      respond_with @domain
    else
      render :action => :new
    end
  end

  def update
    if @domain.update_attributes params[:domain]
      flash[:notice] = I18n.t :domain_updated
      respond_with @domain
    else
      render :action => :edit
    end
  end

  def destroy
    @domain.destroy
    
    respond_with @domain
  end
  
  def monitored
    if @domain.monitor == false
      if current_user.email.nil?
        @user = current_user
      else
        @domain.monitor = true
      end
    
    else
      @domain.monitor = false      
    end
    
    @domain.save
    respond_with @domain
  end
  
  protected
  def init
    @domain = Domain.where(:id => params[:id]).first
  end
    
end
