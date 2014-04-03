class ChangeDayTypeToStringInBusinessHoursTable < ActiveRecord::Migration
  def change
    change_column :business_hours, :day, :string
  end
end
