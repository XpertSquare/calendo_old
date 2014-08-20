class BusinessHour < ActiveRecord::Base
  
  belongs_to :account
  
  default_scope { where(account_id: Account.current_id) }
  
  WEEK_DAYS = [:monday, :tuesday, :wednesday, :thursday, :friday , :saturday, :sunday]
  DEFAULT_OPEN_TIME = "09:00 AM"
  DEFAULT_CLOSE_TIME = "06:00 PM"

end
