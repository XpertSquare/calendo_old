class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.integer :duration
      t.decimal :price, :precision => 8, :scale => 2
      t.integer :account_id

      t.timestamps
    end
    add_index :services, :account_id
  end
end
