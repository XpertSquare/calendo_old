class Admin::StaffController < ApplicationController
  layout "account_admin"
  before_action :authorize!
  before_action :set_user, only: [:edit, :update]
    
  def index
    @staff_users = User.all.with_role(:staff)
    @user = User.new
  end
    
  def new
    @user = User.new
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
  
  def user_params
      params.require(:user).permit(:email, :display_name, :service_ids => [])
  end
    
end
