class EmployeeProfile < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :work_days
  has_many :vacations, :conditions => ["END_DATE >= '#{DateTime.now.beginning_of_year.strftime('%Y-%m-%d')}'::date"], :order => "START_DATE ASC"
  has_many :breaks
  
  accepts_nested_attributes_for :work_days , allow_destroy: true
  accepts_nested_attributes_for :vacations , allow_destroy: true
    
  default_scope { where(account_id: Account.current_id) }
  
  def to_param
    "#{id} #{self.name}".parameterize
  end
  
  def name
    self.user.display_name
  end
end
