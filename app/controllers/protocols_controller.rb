class ProtocolsController < ApplicationController    
  layout 'admin'
  respond_to :html, :xml, :js, :json

  def index
    @protocols = Protocol.order 'created_at DESC'
    
    respond_with @protocols
  end
    
  def show
    @protocol = Protocol.where(:id => params[:id]).first
    
    respond_with @protocol
  end

  def new
    @protocol = Protocol.new
    
    respond_with @protocol
  end

  def edit
    @protocol = Protocol.where(:id => params[:id]).first
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
    @protocol = Protocol.where(:id => params[:id]).first
  
    if @protocol.update_attributes params[:protocol]
      flash[:notice] = I18n.t :protocol_updated
      respond_with @protocol
    else
      render :action => :edit
    end
  end

  def destroy
    @protocol = Protocol.where(:id => params[:id]).first
    @protocol.destroy
    
    respond_with @protocol
  end
    
end
