class Admin::ServicesController < ApplicationController
  layout "account_admin"
  before_action :authorize!
  before_action :set_service, only: [:show, :edit, :update]
  
  def new
    @service = Service.new
  end
  
  def index
    @services = Service.all
    respond_to do |format|      
        format.html 
        format.json { render json: @services }
    end

    
  end
  
   def create
    @service = Service.new(service_params)   
    
    if @service.save      
      respond_to do |format|
        format.html { redirect_to admin_services_path, notice: 'The service ' + @service.name + ' was successfully created.'  }
        format.json { render action: 'show', status: :created, location: @service }
      end
    else            
      @service.errors.full_messages.each do |msg| 
        logger.info msg
      end
      
      respond_to do |format|        
        format.html { render action: 'new' }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end

  end
  
  def update
    
   respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to admin_service_url(:subdomain => current_account.subdomain), notice: 'The service ' + @service.name + ' was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
  end
  
  def show    
    respond_to do |format|      
        format.html 
        format.json { render json: @service }
    end
  end
  
  private

  def set_service
    @service = Service.find(params[:id])
  end
  
  def service_params
      params.require(:service).permit(:name, :description, :duration, :price, :user_ids=>[])
  end
end
