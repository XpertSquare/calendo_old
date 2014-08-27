class CreateBreaks < ActiveRecord::Migration
  def change
    create_table :breaks do |t|
      t.integer :account_id
      t.integer :employee_profile_id
      t.datetime :start
      t.datetime :end
      t.text :note

      t.timestamps
    end
    add_index :breaks, :account_id
    add_index :breaks, :employee_profile_id 
  end
end
