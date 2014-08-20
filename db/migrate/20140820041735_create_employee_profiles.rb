class CreateEmployeeProfiles < ActiveRecord::Migration
  def change
    create_table :employee_profiles do |t|
      t.integer :account_id
      t.integer :user_id
      t.text :biography

      t.timestamps
    end
    add_index :employee_profiles, :account_id
    add_index :employee_profiles, :user_id    
  end
end
