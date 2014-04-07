class Appointment < ActiveRecord::Base
  
  belongs_to :account
  belongs_to :user
  belongs_to :customer_profile
  
  validates_presence_of :start, :duration
  
  default_scope { where(account_id: Account.current_id) }
  
end
