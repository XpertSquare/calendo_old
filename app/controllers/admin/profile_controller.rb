class Admin::ProfileController < ApplicationController
  layout "account_admin"
  before_action :authorize!
  before_action :set_profile, only:  [:show, :edit, :update]
  
  def show
    @account = Account.find(current_account.id)
    respond_to do |format|      
        format.html 
        format.json { render json: @account }
    end
  end
  
  
  def edit
    
  end
  
  def update
    if params[:user][:password].blank?
      params[:user].delete :password
      params[:user].delete :password_confirmation
    end


    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_profile_url(:subdomain=>current_account.subdomain), notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end    
  end
  
private 
  
  def set_profile
    @user = current_user
  end
  
  def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :display_name)
  end
  
end
