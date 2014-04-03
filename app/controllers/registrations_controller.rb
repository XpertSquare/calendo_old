class RegistrationsController < ApplicationController
  def new
    @registration = Registration.new
  end
  
  def create
    @registration = Registration.new(registration_params)
    @registration.ip_address=request.remote_ip
    @registration.status="new"
    
    if @registration.save        
      RegistrationMailer.registration_confirmation(@registration).deliver
      respond_to do |format|
        format.html { redirect_to root_url, notice: 'The registration was successfully submitted.' }
        format.json { render action: 'show', status: :created, location: @registration }
      end
    else
      respond_to do |format|
        format.html { render action: 'new' }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
      
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
    def registration_params
      params.require(:registration).permit(:company_name, :registrar_name, :registrar_email)
    end
end
