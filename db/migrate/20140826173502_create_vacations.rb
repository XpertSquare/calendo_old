class CreateVacations < ActiveRecord::Migration
  def change
    create_table :vacations do |t|
      t.integer :account_id
      t.integer :employee_profile_id
      t.string :name
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
    add_index :vacations, :account_id
    add_index :vacations, :employee_profile_id 
  end
end
