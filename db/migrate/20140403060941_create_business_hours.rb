class CreateBusinessHours < ActiveRecord::Migration
  def change
    create_table :business_hours do |t|
      t.integer :account_id
      t.integer :day
      t.string :open_time
      t.string :close_time
      t.boolean :is_closed

      t.timestamps
    end
    add_index :business_hours, :account_id
  end
end
