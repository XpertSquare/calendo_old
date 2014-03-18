class Admin::ServicesController < ApplicationController
  layout "account"
  before_filter :authorize!
  
  def index
    @services = Service.all
    @service = Service.new
  end
  
   def create
    @service = Service.new(post_params)   
    
    if @service.save 
      flash[:notice] = "The service was successfully created."   
      respond_to do |format|
        format.js
        format.html { redirect_to admin_services_path }
        format.json { render action: 'show', status: :created, location: @service }
      end
    else
      flash[:notice] = "There was an error creating the service." 
      logger.info "Error when saving service"
      @service.errors.full_messages.each do |msg| 
        logger.info msg
      end
      
      respond_to do |format|
        format.js
        format.html { render action: 'new' }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end

  end
  
  
  def post_params
      params.require(:service).permit(:name, :description, :duration, :price)
    end
end
