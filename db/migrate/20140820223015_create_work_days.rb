class CreateWorkDays < ActiveRecord::Migration
  def change
    create_table :work_days do |t|
      t.integer :account_id
      t.integer :employee_profile_id
      t.string :day
      t.string :start_time
      t.string :end_time
      t.boolean :is_off

      t.timestamps
    end
    add_index :work_days, :account_id
    add_index :work_days, :employee_profile_id 
  end
end
