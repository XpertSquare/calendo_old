class Admin::AccountController < ApplicationController
  layout "account_admin"
  before_action :authorize!
  before_action :set_account, only: [:show, :edit, :update]
  
  def edit
    @account = Account.find(current_account.id)
    respond_to do |format|      
        format.html 
        format.json { render json: @account }
    end
  end
  
  def show
    @account = Account.find(current_account.id)
    respond_to do |format|      
        format.html 
        format.json { render json: @account }
    end
  end
  
  def update
    
   respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to admin_account_url(:subdomain=>@account.subdomain), notice: 'Account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private 
  
   def set_account
     @account = current_account
    end
  
  def account_params
      params.require(:account).permit(:name, :time_zone, :subdomain)
  end
  
end
