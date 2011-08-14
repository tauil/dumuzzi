class HostsController < ApplicationController    
  layout 'admin'
  respond_to :html, :xml, :js

  def index
    @hosts = Host.order 'created_at DESC'
    
    respond_with @hosts
  end
    
  def show
    @host = Host.where(:id => params[:id]).first
    
    respond_with @host
  end

  def new
    @host = Host.new
    
    respond_with @host
  end

  def edit
    @host = Host.where(:id => params[:id]).first
    respond_with @host
  end

  def create
    @host = Host.new params[:host]
    
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
    @host.destroy
    
    respond_with @host
  end
    
end
