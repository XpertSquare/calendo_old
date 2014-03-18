class Admin::ServicesController < ApplicationController
  layout "account_admin"
  before_filter :authorize!
  
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
    @service = Service.new(post_params)   
    
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
        format.js
        format.html { render action: 'new' }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end

  end
  
  def edit
  end
  
  def show
    @service = Service.find(params[:id])
    respond_to do |format|      
        format.html 
        format.json { render json: @service }
    end
  end
  
  
  def post_params
      params.require(:service).permit(:name, :description, :duration, :price)
    end
end
