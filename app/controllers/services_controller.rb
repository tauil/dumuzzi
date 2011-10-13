class ServicesController < ApplicationController    
  respond_to :html, :xml, :js, :json

  def index
    @services = Service.order 'created_at DESC'
    
    respond_with @services
  end
    
  def show
    @service = Service.where(:id => params[:id]).first
    
    respond_with @service
  end

  def new
    @service = Service.new
    @protocol = Protocol.all
    
    respond_with @service
  end

  def edit
    @service = Service.where(:id => params[:id]).first
    @protocol = Protocol.all
    respond_with @service
  end

  def create
    @service = Service.new params[:service]
    
    if @service.save
      flash[:notice] = I18n.t :service_created
      respond_with @service
    else
      render :action => :new
    end
  end

  def update
    @service = Service.where(:id => params[:id]).first
  
    if @service.update_attributes params[:service]
      flash[:notice] = I18n.t :service_updated
      respond_with @service
    else
      render :action => :edit
    end
  end

  def destroy
    @service = Service.where(:id => params[:id]).first
    @service.destroy
    
    respond_with @service
  end
    
end
