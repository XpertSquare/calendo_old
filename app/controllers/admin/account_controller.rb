class Admin::AccountController < ApplicationController
  layout "account_admin"
  before_filter :authorize!
  
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
    @account = Account.find(current_account.id)
    if @account.update_column("name", params[:name])
      #flash[:notice] = "Successfully updated account."
      logger.debug "Successfully updated account."
      redirect_to admin_account_path
    else
      render :action => 'edit'
    end
  end
  
  private 
  def post_params
      params.require(:account).permit(:name, :time_zone)
  end
  
end
