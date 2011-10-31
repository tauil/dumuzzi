class ServicesController < ApplicationController 
  before_filter :init, :only => [:show, :edit, :update, :destroy]
  
  respond_to :html, :xml, :js, :json

  def index
    @services = Service.order 'created_at DESC'
    
    respond_with @services
  end
    
  def show
    respond_with @service
  end

  def new
    @service = Service.new
    @protocol = Protocol.all
    
    respond_with @service
  end

  def edit
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
    if @service.update_attributes params[:service]
      flash[:notice] = I18n.t :service_updated
      respond_with @service
    else
      render :action => :edit
    end
  end

  def destroy
    @service.destroy
    
    respond_with @service
  end
  
  protected
  def init
    @service = Service.where(:id => params[:id]).first
  end
    
end
