class AddGatewayToHosts < ActiveRecord::Migration
  def change
    add_column :hosts, :gateway, :string
    add_index :hosts, :gateway
  end
end
