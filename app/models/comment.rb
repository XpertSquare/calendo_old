class Comment < ActiveRecord::Base
  
  belongs_to :account
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  
  validate_presence_of :content
  
  default_scope { where(account_id: Account.current_id) }
  
end
