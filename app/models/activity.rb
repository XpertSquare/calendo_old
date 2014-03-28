class Activity < ActiveRecord::Base
  
  belongs_to :account
  belongs_to :user
  belongs_to :trackable, polymorphic: true
  #attr_accessible :action, :trackable
  
  default_scope { where(account_id: Account.current_id) }
  
end
