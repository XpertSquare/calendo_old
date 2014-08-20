class WorkDay < ActiveRecord::Base
  
  belongs_to :employee_profile
  
  default_scope { where(account_id: Account.current_id) }
  
end
