class CustomerProfile < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :activities, as: :recipient
  
  default_scope { where(account_id: Account.current_id) }
  
  def to_param
    "#{id} #{self.user.display_name}".parameterize
  end
  
  def name
    self.user.display_name
  end
  
end
