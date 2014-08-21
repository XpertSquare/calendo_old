class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.integer :account_id
      t.string :name
      t.datetime :date

      t.timestamps
    end
    add_index :holidays, :account_id
  end
end
