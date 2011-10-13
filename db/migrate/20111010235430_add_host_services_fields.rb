class AddHostServicesFields < ActiveRecord::Migration
  def change
    add_column :hosts_services, :host_service_id, :integer
    add_index :hosts_services, :host_service_id
  end
end
