class AddGatewayStateToHosts < ActiveRecord::Migration
  def change
    add_column :hosts, :gateway_state, :boolean, :default => false
    add_index :hosts, :gateway_state  
  end
end
