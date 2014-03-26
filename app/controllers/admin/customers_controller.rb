class Admin::CustomersController < ApplicationController
  #layout "account", :only => :index
  layout "customer_admin", :except => :index
  before_action :authorize!
  before_action :set_customer, only: [:show, :edit, :update, :activity]
  
  def index
    @customers = User.all.with_role(:customer) 
    render(:layout => "layouts/account")
       
  end
  
  def new
    @customer = User.new
    render(:layout => "layouts/account")
  end
  
  def create
    
    @user = User.new(customer_params) 
    
    @user.generate_password
    logger.info "User password: " + @user.password
    #Required to bypass the "has_secure_password" when an account is created
    @user.password_confirmation = @user.password
    @user.roles = %w[customer]  
    
    if @user.save       
      @customer_profile = CustomerProfile.new(user_id: @user.id)
      if @customer_profile.save             
        respond_to do |format|
          format.html { redirect_to customers_url(:subdomain => current_account.subdomain), notice: 'The customer ' + @user.display_name + ' was successfully added to the account.'  }
          format.json { render action: 'show', status: :created, location: @user }
        end
      else
        respond_to do |format|
          format.html { render action: 'new' }
          format.json { render json: @customer_profile.errors, status: :unprocessable_entity }
        end
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
  
  def show
    
  end
  
  def activity
    
  end
  
private

  def set_customer
    @customer = User.find(params[:id])
  end
  
  def customer_params
      params.require(:user).permit(:email, :display_name)
  end
end
