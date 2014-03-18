class Admin::UsersController < ApplicationController
  layout "account_admin"
  before_filter :authorize!
  
  def index
    @users = User.all
    respond_to do |format|      
        format.html 
        format.json { render json: @users }
    end
  end
  
  def edit
    @user = User.find(params[:id])
    respond_to do |format|      
        format.html 
        format.json { render json: @user }
    end
  end
  
end
