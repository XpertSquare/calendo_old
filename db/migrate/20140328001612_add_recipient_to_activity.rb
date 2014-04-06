class AddRecipientToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :recipient_id, :integer
    add_column :activities, :recipient_type, :string
    add_index :activities, [:recipient_id, :recipient_type], :name => "index_activities_on_recipient_id_and_recipient_type"
  end
end
