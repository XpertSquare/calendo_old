class CustomerProfile < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  
  default_scope { where(account_id: Account.current_id) }
  
end
