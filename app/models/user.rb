class User < ActiveRecord::Base
  
  has_one :owner
  belongs_to :account
  
  default_scope { where(account_id: Account.current_id) }
  
end
