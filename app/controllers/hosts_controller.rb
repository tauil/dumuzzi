class HostsController < ApplicationController    
  respond_to :html, :xml, :js, :json

  def index
    @hosts = Host.where(:user_id => current_user.id).order('created_at DESC')
    
    respond_with @hosts
  end
    
  def show
    @host = Host.where(:id => params[:id]).first
    service_host_activate_id = Service.find_by_plugin('host_activate').id
    @hosts_service = HostsService.where("service_id <> '#{service_host_activate_id}'").where(:host_id => @host.id)
    
    respond_with @host
  end

  def new
    @host = Host.new(:domain_id => params[:domain_id])
    @domain = Domain.where(:id => @host.domain.id).first
    @domains = Domain.where(:id => @host.domain.id)

    respond_with @host
  end

  def edit
    @host = Host.where(:id => params[:id]).first
    @domain = Domain.where(:id => @host.domain.id).first
    @domains = Domain.where(:id => @host.domain.id)

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
