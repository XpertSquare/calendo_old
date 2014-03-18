class Admin::DashboardController < ApplicationController
  layout "account"
  
  #before_filter :require_permission

  before_filter :authorize!

  def index
    @users = User.all
  end
  
end
