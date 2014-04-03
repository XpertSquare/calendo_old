class BusinessHour < ActiveRecord::Base
  
  belongs_to :account
  
  default_scope { where(account_id: Account.current_id) }
  
  WEEK_DAYS = [:monday, :tuesday, :wednesday, :thursday, :friday , :saturday, :sunday]
  DEFAULT_OPEN_TIME = "09:00 AM"
  DEFAULT_CLOSE_TIME = "06:00 PM"
  HOURS_LIST = ["00:00 AM", "00:30 AM", "01:00 AM", "01:30 AM", 
    "02:00 AM", "02:30 AM", "03:00 AM", "03:30 AM", "04:00 AM", "04:30 AM",
    "05:00 AM", "05:30 AM", "06:00 AM", "06:30 AM", "07:00 AM", "07:30 AM",
    "08:00 AM", "08:30 AM", "09:00 AM", "09:30 AM", "10:00 AM", "10:30 AM",
    "11:00 AM", "11:30 AM", "12:00 PM", "12:30 PM", "01:00 PM", "01:30 PM",
    "02:00 PM", "02:30 PM", "03:00 PM", "03:30 PM", "04:00 PM", "04:30 PM",
    "05:00 PM", "05:30 PM", "06:00 PM", "06:30 PM", "07:00 PM", "07:30 PM",
    "08:00 PM", "08:30 PM", "09:00 PM", "09:30 PM", "10:00 PM", "10:30 PM",
    "11:00 PM", "11:30 PM" ]
  
end
