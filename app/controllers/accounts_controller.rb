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
    @account.save
    
    @user=User.new
    @user.email = @account.user_email   
    @user.account_id= @account.id

    logger.debug('Subdomain for ' + @account.name + ' is: ' + @account.subdomain)
    logger.debug('User email for ' + @account.name + ' is: ' + @account.user_email)

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_url(:subdomain=>@account.subdomain), notice: 'The account ' + @account.name + ' was successfully created.' }
        format.json { render action: 'show', status: :created, location: @account }
      else
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
