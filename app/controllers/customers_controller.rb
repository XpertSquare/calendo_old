class CustomersController < ApplicationController
  layout "account"
  before_action :authorize!
  before_action :set_customer, only: [:show, :edit, :update]
  
  def index
    @customers = User.all.with_role(:customer)    
  end
  
  def new
    @customer = User.new
  end
  
  def create
     @customer = User.new(customer_params) 
    flash[:notice] = 'The customer ' + @customer.display_name + ' was successfully added to the account.'  
    redirect_to customers_url(:subdomain => current_account.subdomain)
  end
  
private

  def set_customer
    @customer = User.find(params[:id])
  end
  
  def customer_params
      params.require(:user).permit(:email, :display_name)
  end
  
end
