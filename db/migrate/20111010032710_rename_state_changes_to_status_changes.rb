class RenameStateChangesToStatusChanges < ActiveRecord::Migration
  def change
    rename_table :state_changes, :status_changes
    rename_column :status_changes, :host_id, :hosts_services_id
    rename_index :status_changes, :host_id, :hosts_services_id
  end
end
