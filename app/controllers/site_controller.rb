class SiteController < ApplicationController
  def index
    @account = Account.new  
  end
end
