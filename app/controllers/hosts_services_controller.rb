class HostsServicesController < ApplicationController
  before_filter :init, :only => [:show, :edit, :update, :destroy, :manual_test, :threads_test]
  
  respond_to :html, :xml, :js, :json

  def index
    @hosts_services = HostsService.where(:user_id => current_user.id).order('created_at DESC')
    
    respond_with @hosts_services
  end
    
  def show 
    respond_with @hosts_service
  end

  def new
    @hosts_service = HostsService.new :host_id => params[:host_id]
    @hosts_service.user = @hosts_service.host.user
    @hosts_service.domain = @hosts_service.host.domain
    @services = Service.where(:enabled => true, :monitor => true, :public => true)
    @intervals = Interval.where(:enabled => true, :public => true)
    @hosts = Host.where(:domain_id => @hosts_service.host.domain.id).order('created_at DESC')
    
    respond_with @hosts_service
  end

  def edit
    @services = Service.where(:enabled => true, :monitor => true, :public => true, :id => @hosts_service.service.id)
    @intervals = Interval.where(:enabled => true, :public => true)
    @hosts = Host.where(:id => @hosts_service.host.id)
    respond_with @hosts_service
  end

  def create
    @hosts_service = HostsService.new params[:hosts_service]
    @hosts_service.user = @hosts_service.host.user
    @hosts_service.domain = @hosts_service.host.domain
    @hosts_service.enabled = true
    
    if @hosts_service.save
      flash[:notice] = I18n.t :hosts_service_created
      respond_with @hosts_service
    else
      render :action => :new
    end
  end

  def update
    @hosts_service.enabled = true
  
    if @hosts_service.update_attributes params[:hosts_service]
      flash[:notice] = I18n.t :hosts_service_updated
      respond_with @hosts_service
    else
      render :action => :edit
    end
  end

  def destroy
    @hosts_service.destroy
    
    respond_with @hosts_service
  end
  
  def threads_test
    worker_response = MiddleMan.worker(:monitor_worker).threads_test(:arg => {:id => @host_service.id})
    redirect_to @hosts_service.host, notice: "Threads Test was successfully queued. Result => #{worker_response}"
  end
    
  def manual_test
    worker_response = MiddleMan.worker(:monitor_worker).services_check(:arg => {:id => @host_service.id})
    redirect_to @host_service, notice: "Manual Test was successfully executed. Result => #{worker_response}"
  end
  
  protected
  def init
    @hosts_service = HostsService.where(:id => params[:id]).first
  end
    
end
