class HostsServicesController < ApplicationController    
  layout 'admin'
  respond_to :html, :xml, :js

  def index
    @hosts_services = HostsService.order 'created_at DESC'
    
    respond_with @hosts_services
  end
    
  def show
    @hosts_service = HostsService.where(:id => params[:id]).first
    
    respond_with @hosts_service
  end

  def new
    @hosts_service = HostsService.new
    
    respond_with @hosts_service
  end

  def edit
    @hosts_service = HostsService.where(:id => params[:id]).first
    respond_with @hosts_service
  end

  def create
    @hosts_service = HostsService.new params[:hosts_service]
    
    if @hosts_service.save
      flash[:notice] = I18n.t :hosts_service_created
      respond_with @hosts_service
    else
      render :action => :new
    end
  end

  def update
    @hosts_service = HostsService.where(:id => params[:id]).first
  
    if @hosts_service.update_attributes params[:hosts_service]
      flash[:notice] = I18n.t :hosts_service_updated
      respond_with @hosts_service
    else
      render :action => :edit
    end
  end

  def destroy
    @hosts_service = HostsService.where(:id => params[:id]).first
    @hosts_service.destroy
    
    respond_with @hosts_service
  end
    
end
