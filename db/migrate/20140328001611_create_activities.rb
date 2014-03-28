class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :account_id
      t.integer :user_id
      t.string  :action
      t.integer :trackable_id
      t.string  :trackable_type

      t.timestamps
    end
    add_index :activities, :account_id
    add_index :activities, :user_id
    add_index :activities, [:trackable_id, :trackable_type]
  end
end
