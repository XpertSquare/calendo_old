class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :account_id
      t.integer :user_id
      t.integer :customer_profile_id
      t.datetime :start
      t.datetime :end
      t.integer :duration
      t.integer :price

      t.timestamps
    end
    add_index :appointments, :account_id
  end
end
