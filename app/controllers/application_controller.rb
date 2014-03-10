class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
   
  around_action :scope_current_account

private

  
  def current_account    
    if request.subdomain.present? && !Account.is_reserved_subdomain(request.subdomains.last)
      Account.find_by_subdomain! request.subdomains.last
    end
  end
  helper_method :current_account
  
  
  def scope_current_account
      if current_account
        Account.current_id = current_account.id        
      end
      yield
  ensure
    Account.current_id = nil
  end
  
end
