class QueuedsController < ApplicationController
  before_filter :init, :only => [:show, :edit, :update, :destroy]
  
  respond_to :html, :xml, :js, :json

  def index
    @queueds = Queued.order 'created_at DESC'
    
    respond_with @queueds
  end
    
  def show
    respond_with @queued
  end

  def new
    @queued = Queued.new
    
    respond_with @queued
  end

  def edit
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
    if @queued.update_attributes params[:queued]
      flash[:notice] = I18n.t :queued_updated
      respond_with @queued
    else
      render :action => :edit
    end
  end

  def destroy
    @queued.destroy
    
    respond_with @queued
  end
  
  protected
  def init
    @queued = Queued.where(:id => params[:id]).first
  end
    
end
