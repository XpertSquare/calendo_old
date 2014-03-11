class Admin::DashboardController < ApplicationController
  layout "account"
  
  #before_filter :require_permission

  before_filter :authorize!

  def index
    @users = User.all
  end
  
private

  def require_permission
    if !current_user.with_role("owner") 
      redirect_to root_path
    end
  end
  
end
