class StateChangesController < ApplicationController    
  respond_to :html, :xml, :js, :json

  def index
    @state_changes = StateChange.order 'created_at DESC'
    
    respond_with @state_changes
  end
    
  def show
    @state_change = StateChange.where(:id => params[:id]).first
    
    respond_with @state_change
  end

  def new
    @state_change = StateChange.new
    
    respond_with @state_change
  end

  def edit
    @state_change = StateChange.where(:id => params[:id]).first
    respond_with @state_change
  end

  def create
    @state_change = StateChange.new params[:state_change]
    
    if @state_change.save
      flash[:notice] = I18n.t :state_change_created
      respond_with @state_change
    else
      render :action => :new
    end
  end

  def update
    @state_change = StateChange.where(:id => params[:id]).first
  
    if @state_change.update_attributes params[:state_change]
      flash[:notice] = I18n.t :state_change_updated
      respond_with @state_change
    else
      render :action => :edit
    end
  end

  def destroy
    @state_change = StateChange.where(:id => params[:id]).first
    @state_change.destroy
    
    respond_with @state_change
  end
    
end
