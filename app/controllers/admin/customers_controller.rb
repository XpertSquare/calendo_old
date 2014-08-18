class Admin::CustomersController < ApplicationController
  #layout "account", :only => :index
  layout "customer_admin", :except => :index
  before_action :authorize!
  before_action :set_customer_profile, only: [:show, :edit, :update, :activity, :comments, :invoices]
  
  def index
    #@customers = User.all.with_role(:customer) 
    @customers = CustomerProfile.all
    
    
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
          format.html { redirect_to admin_customers_url(:subdomain => current_account.subdomain), notice: 'The customer ' + @user.display_name + ' was successfully added to the account.'  }
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
    @comment = Comment.new
  end
  
  def activity
    @activities = Activity.where(:recipient_id => @customer.id, :recipient_type => 'CustomerProfile')
    @activities_months = @activities.group_by { |t| t.created_at.beginning_of_month }    
  end
  
  def comments
    
  end
  
  def invoices
    #TODO: add code for invoices when the model is created
  end
  
  
  def search
    @search = params[:query].downcase
    @customers = User.with_role(:customer).where("lower(display_name) like ?", "%#{@search}%");  
    respond_to do |format|      
      format.json { render :layout => false}      
    end
  end
  
  
private

  def set_customer_profile
    @customer = CustomerProfile.find(params[:id])
  end
  
  def customer_params
      params.require(:user).permit(:email, :display_name, :customer_profile =>{})
  end
end
