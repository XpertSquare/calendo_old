class AccountsController < ApplicationController

  before_action :authorize_access

  def index
    @accounts = Account.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accounts }
    end
  end
  
  def new
    @account=Account.new
  end
  
  def create
    @account = Account.new(post_params)     
    @account.subdomain = @account.name.parameterize
    if @account.save
    
      @user=User.new
      @user.email = @account.user_email   
      @user.account_id= @account.id
      @user.roles = %w[client staff admin owner]
      @user.generate_password
      logger.info "User password: " + @user.password
      #Required to bypass the "has_secure_password" when an account is created
      @user.password_confirmation = @user.password
    
      if @user.save
        respond_to do |format|
          format.html { redirect_to admin_url(:subdomain=>@account.subdomain), notice: 'The account ' + @account.name + ' was successfully created.' }
          format.json { render action: 'show', status: :created, location: @account }
        end
      else
        respond_to do |format|
          format.html { render action: 'new' }
          format.json { render json: @account.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render action: 'new' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
    
  end
 
 # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:account).permit(:name, :user_name, :user_email, :time_zone)
    end
 
 
 def authorize_access
   if current_account
     redirect_to :root  
   end
 end
  
end
