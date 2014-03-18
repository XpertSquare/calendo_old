class Admin::ServicesController < ApplicationController
  layout "account"
  before_filter :authorize!
  
  def index
    @services = Service.all
  end
end
