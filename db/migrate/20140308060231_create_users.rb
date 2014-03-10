class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.integer :account_id

      t.timestamps
    end
    add_index :users, :account_id
  end
end
