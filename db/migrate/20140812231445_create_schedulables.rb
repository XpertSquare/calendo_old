class CreateSchedulables < ActiveRecord::Migration
  def change
    create_table :schedulables do |t|
      t.integer :service_id
      t.integer :appointment_id

      t.timestamps
    end
  end
end
