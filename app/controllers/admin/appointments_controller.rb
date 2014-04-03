class Admin::AppointmentsController < ApplicationController
  
  layout "account", only: [:schedule]
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
    
  end
  

  private

 
  def appointment_params
      params.require(:appointment).permit(:start, :duration)
  end
end
