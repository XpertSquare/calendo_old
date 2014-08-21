class Admin::StaffController < ApplicationController
  layout "account_admin"
  before_action :authorize!
  before_action :set_user, only: [:edit, :update]
  
  #before_action :set_employee_profile, only: [:edit, :update]
    
  def index
   # @staff_users = User.all.with_role(:staff)
    @employee_profiles = EmployeeProfile.all.includes(:user)
    @user = User.new
  end
    
  def new
    @user = User.new
    @user.employee_profile = EmployeeProfile.new
    #Defaulting the work days to account's business hours

    current_account.business_hours.reverse.each do |day|
        @work_day = WorkDay.new
        #@work_day.account_id = current_account.id
        @work_day.day = day.day        
        @work_day.start_time = day.open_time
        @work_day.end_time = day.close_time
        @work_day.is_off = day.is_closed
        @user.employee_profile.work_days << @work_day          
    end
  end    
    
  def create
    @user = User.new(user_params) 
    
    @user.generate_password
    logger.info "User password: " + @user.password
    #Required to bypass the "has_secure_password" when an account is created
    @user.password_confirmation = @user.password
    @user.roles = %w[staff]  
    
    if @user.save      
      respond_to do |format|
        format.html { redirect_to admin_staff_index_url(:subdomain => current_account.subdomain), notice: 'The person ' + @user.display_name + ' was successfully added to the account staff.'  }
        format.json { render action: 'show', status: :created, location: @user }
      end
    else            
      @user.errors.full_messages.each do |msg| 
        logger.debug msg
      end
      
      respond_to do |format|        
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end  
    

  
  def edit
    # TODO: to delete the below logic before deployment
    if (@user.employee_profile.work_days.count ==0)
      current_account.business_hours.reverse.each do |day|          
          @work_day = WorkDay.new
          #@work_day.account_id = current_account.id
          @work_day.day = day.day
   
          @work_day.start_time = day.open_time
          @work_day.end_time = day.close_time
          @work_day.is_off = day.is_closed
          @user.employee_profile.work_days << @work_day          
      end
      @user.save!
    end
    
    @user.employee_profile.work_days.reverse
    
  end
  
  def update
    
   respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_staff_index_url(:subdomain => current_account.subdomain), notice: 'The person ' + @user.display_name + ' was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  def set_service
    @service = Service.find(params[:id])
  end
  
  private

  def set_user
    @user = User.find(params[:id])
  end
  
  def set_employee_profile
    @employee_profile = EmployeeProfile.find(params[:id])
  end
  
  def user_params
      params.require(:user).permit(:email, :display_name, :service_ids => [], :employee_profile_attributes=>[:id, :biography,  :work_days_attributes => [:id, :day, :start_time, :end_time, :is_off ]])
  end
    
end
