class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.integer :account_id

      t.timestamps
    end
    add_index :owners, :account_id
  end
end
