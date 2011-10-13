class RenameStatusChangesFields < ActiveRecord::Migration
  def change
    rename_column :status_changes, :hosts_services_id, :hosts_service_id
    add_column :status_changes, :host_id, :string, :null => false
    add_index :status_changes, :host_id
  end
end
