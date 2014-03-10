class Owner < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  
  default_scope { where(account_id: Account.current_id) }
end
