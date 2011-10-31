class ProtocolsController < ApplicationController
  before_filter :init, :only => [:show, :edit, :update, :destroy]
  
  respond_to :html, :xml, :js, :json

  def index
    @protocols = Protocol.order 'created_at DESC'
    
    respond_with @protocols
  end
    
  def show    
    respond_with @protocol
  end

  def new
    @protocol = Protocol.new
    
    respond_with @protocol
  end

  def edit
    respond_with @protocol
  end

  def create
    @protocol = Protocol.new params[:protocol]
    
    if @protocol.save
      flash[:notice] = I18n.t :protocol_created
      respond_with @protocol
    else
      render :action => :new
    end
  end

  def update
  
    if @protocol.update_attributes params[:protocol]
      flash[:notice] = I18n.t :protocol_updated
      respond_with @protocol
    else
      render :action => :edit
    end
  end

  def destroy
    @protocol.destroy
    
    respond_with @protocol
  end
  
  protected
  def init
    @protocol = Protocol.where(:id => params[:id]).first
  end
    
end
