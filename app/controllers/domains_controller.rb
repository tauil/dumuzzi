class DomainsController < ApplicationController    
  layout 'admin'
  respond_to :html, :xml, :js, :json

  def index
    @domains = Domain.order 'created_at DESC'
    
    respond_with @domains
  end
    
  def show
    @domain = Domain.where(:id => params[:id]).first
    @hosts = @domain.hosts
    
    respond_with @domain
  end

  def new
    @domain = Domain.new
    
    respond_with @domain
  end

  def edit
    @domain = Domain.where(:id => params[:id]).first
    respond_with @domain
  end

  def create
    @domain = Domain.new params[:domain]
    
    if @domain.save
      flash[:notice] = I18n.t :domain_created
      respond_with @domain
    else
      render :action => :new
    end
  end

  def update
    @domain = Domain.where(:id => params[:id]).first
  
    if @domain.update_attributes params[:domain]
      flash[:notice] = I18n.t :domain_updated
      respond_with @domain
    else
      render :action => :edit
    end
  end

  def destroy
    @domain = Domain.where(:id => params[:id]).first
    @domain.destroy
    
    respond_with @domain
  end
    
end
