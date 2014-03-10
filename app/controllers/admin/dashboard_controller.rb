class Admin::DashboardController < ApplicationController
  layout "account"
  
  
  def index
    @users = User.all
  end
end
