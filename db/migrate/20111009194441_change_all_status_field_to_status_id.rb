class ChangeAllStatusFieldToStatusId < ActiveRecord::Migration
  def up
    rename_column :domains, :status, :status_id
    rename_column :hosts, :status, :status_id
    rename_column :hosts_services, :status, :status_id
    rename_column :queueds, :status, :status_id
    rename_column :state_changes, :from_status, :from_status_id
    rename_column :state_changes, :to_status, :to_status_id
    rename_column :state_changes, :status, :status_id
  end
end
