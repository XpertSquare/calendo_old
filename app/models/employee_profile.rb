class EmployeeProfile < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  has_many :comments, as: :commentable
    
  default_scope { where(account_id: Account.current_id) }
  
  def to_param
    "#{id} #{self.name}".parameterize
  end
  
  def name
    self.user.display_name
  end
end
