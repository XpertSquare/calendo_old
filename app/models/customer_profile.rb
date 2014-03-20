class CustomerProfile < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  has_many :comments, as: :commentable
  
  default_scope { where(account_id: Account.current_id) }
  
end
