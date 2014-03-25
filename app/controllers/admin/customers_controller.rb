class Admin::CustomersController < ApplicationController
  #layout "account", :only => :index
  layout "customer_admin", :except => :index
  before_action :authorize!
  before_action :set_customer, only: [:show, :edit, :update]
  
  def index
    @customers = User.all.with_role(:customer) 
    render(:layout => "layouts/account")
       
  end
  
  def new
    @customer = User.new
  end
  
  def create
     @customer = User.new(customer_params) 
    flash[:notice] = 'The customer ' + @customer.display_name + ' was successfully added to the account.'  
    redirect_to customers_url(:subdomain => current_account.subdomain)
  end
  
  def show
    
  end
  
private

  def set_customer
    @customer = User.find(params[:id])
  end
  
  def customer_params
      params.require(:user).permit(:email, :display_name)
  end
end
