class HostsController < ApplicationController    
  respond_to :html, :xml, :js, :json

  def index
    @hosts = Host.where(:user_id => current_user.id).order('created_at DESC')
    
    respond_with @hosts
  end
    
  def show
    @host = Host.where(:id => params[:id]).first
    @hosts_service = @host.hosts_service
    
    respond_with @host
  end

  def new
    @host = Host.new(:domain_id => [ "?", params[:domain_id] ])
    @domain = Domain.all
    
    respond_with @host
  end

  def edit
    @host = Host.where(:id => params[:id]).first
    @domain = Domain.all
    respond_with @host
  end

  def create
    @host = Host.new params[:host]
    @host.user_id = current_user.id
    
    if @host.save
      flash[:notice] = I18n.t :host_created
      respond_with @host
    else
      render :action => :new
    end
  end

  def update
    @host = Host.where(:id => params[:id]).first
  
    if @host.update_attributes params[:host]
      flash[:notice] = I18n.t :host_updated
      respond_with @host
    else
      render :action => :edit
    end
  end

  def destroy
    @host = Host.where(:id => params[:id]).first
    domain = @host.domain
    @host.destroy
    
    respond_with @host
  end
    
end
