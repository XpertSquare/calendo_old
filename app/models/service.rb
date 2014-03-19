class Service < ActiveRecord::Base
  belongs_to :account
  
  validates_presence_of :name,:description, :duration, :price
  validates :price, :format => { :with => /\A\d{1,6}(\.\d{0,2})?\z/ , :message => "is invalid. The accepted format is 999999.99 ."}
  
  default_scope { where(account_id: Account.current_id) }
end
