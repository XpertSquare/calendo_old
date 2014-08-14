class Admin::AppointmentsController < ApplicationController
  
  layout false, only: [:schedule]
  before_action :authorize!

  def create
    
    flash[:notice] = "The appointment was successfully added."
    logger.debug "The appointment was successfully created!"

     @appointment = Appointment.new(appointment_params)
     @appointment.user_id = current_user.id
    if @appointment.save
      #track_activity @comment, @commentable
      respond_to do |format|
        format.js
      end
    end    
  end
  
  def schedule
    @appointment = Appointment.new
    @services = Service.all
    @employees = User.all.with_role(:staff)
    @customers = CustomerProfile.all
    
  end
  
  
  def index
    @appointments = Appointment.all    
    respond_to do |format|      
      format.json { render :layout => false}      
    end
  end
  
  
  def crud
    @id = params["id"]
    @tid = @id
    @text = params[:text]    
    @start_date = params[:start_date].to_time().strftime('%Y-%m-%d %H:%M:%S')
    @end_date = params[:end_date].to_time().strftime('%Y-%m-%d %H:%M:%S')
    @customer_profile_id = params[:customer_profile_id]
    @user_id = params[:unit_id]
    @duration = params[:duration]
    @price = params[:price]
    @mode = params["!nativeeditor_status"]
    
    
    if @mode == "inserted"
      @appointment = Appointment.new      
      @appointment.start = @start_date
      @appointment.end = @end_date
      @appointment.duration = @duration
      @appointment.price = @price
      @appointment.customer_profile_id = @customer_profile_id
      @appointment.user_id = @user_id 
      
      @appointment.save!
      @tid = @appointment.id
    elsif @mode == "deleted"
      @appointment=Appointment.find(@id)
      @appointment.destroy
    elsif @mode == "updated"
      @appointment=Appointment.find(@id)      
      @appointment.start = @start_date
      @appointment.end = @end_date
      @appointment.duration = @duration
      @appointment.price = @price
      @appointment.customer_profile_id = @customer_profile_id
      @appointment.user_id = @user_id      
      
      @appointment.save!
     
    end
    request.format = "xml"
    respond_to do |format|
      format.xml {render :layout => false}
    end
  end

  private

 
  def appointment_params
      params.require(:appointment).permit(:start, :duration)
  end
end
