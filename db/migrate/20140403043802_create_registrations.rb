class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :company_name
      t.string :registrar_name
      t.string :registrar_email
      t.string :status
      t.string :token
      t.string :ip_address

      t.timestamps
    end
    
    add_index :registrations, :token
    
  end
end
