class Holiday < ActiveRecord::Base
  belongs_to :account
  validates_presence_of :name, :date
  
  default_scope { where(account_id: Account.current_id) }
end
