class HostsController < ApplicationController
  before_filter :init, :only => [:show, :edit, :update, :destroy]
    
  respond_to :html, :xml, :js, :json

  def index
    @hosts = Host.where(:domain_id => @domain.id, :is_domain_host => false).order('created_at ASC')
    
    respond_with @hosts
  end
    
  def show
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
    if @host.update_attributes params[:host]
      flash[:notice] = I18n.t :host_updated
      respond_with @host
    else
      render :action => :edit
    end
  end

  def destroy
    domain = @host.domain
    @host.destroy
    
    respond_with @host
  end
  
  protected
  def init
    @host = Host.where(:id => params[:id]).first
  end
    
end
