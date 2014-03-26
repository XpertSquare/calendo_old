class CreateCustomerProfiles < ActiveRecord::Migration
  def change
    create_table :customer_profiles do |t|
      t.integer :user_id
      t.integer :account_id

      t.timestamps
    end
    add_index :customer_profiles, :user_id
    add_index :customer_profiles, :account_id
  end
end
