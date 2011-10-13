class QueuedsController < ApplicationController    
  respond_to :html, :xml, :js, :json

  def index
    @queueds = Queued.order 'created_at DESC'
    
    respond_with @queueds
  end
    
  def show
    @queued = Queued.where(:id => params[:id]).first
    
    respond_with @queued
  end

  def new
    @queued = Queued.new
    
    respond_with @queued
  end

  def edit
    @queued = Queued.where(:id => params[:id]).first
    respond_with @queued
  end

  def create
    @queued = Queued.new params[:queued]
    
    if @queued.save
      flash[:notice] = I18n.t :queued_created
      respond_with @queued
    else
      render :action => :new
    end
  end

  def update
    @queued = Queued.where(:id => params[:id]).first
  
    if @queued.update_attributes params[:queued]
      flash[:notice] = I18n.t :queued_updated
      respond_with @queued
    else
      render :action => :edit
    end
  end

  def destroy
    @queued = Queued.where(:id => params[:id]).first
    @queued.destroy
    
    respond_with @queued
  end
    
end
