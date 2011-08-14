class CreateHostsServices < ActiveRecord::Migration
  def change
    create_table :hosts_services, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8', :id => false  do |t|
      t.string :uuid, :null => false
      t.string :host_id, :null => false
      t.string :service_id, :null => false
      t.string :user_id, :null => false
      t.integer :interval_id, :default => 0 # in secounds  [ 60, 120, 300, 1000, 5000 ... 3600, 21600 ... ] 
      t.text :description
      t.integer :status, :default => -1
      t.boolean :monitor, :default => false
      t.boolean :enabled, :default => false
      t.timestamps
    end
    rename_column :hosts_services, :uuid, :id
    ActiveRecord::Base.connection.execute("ALTER TABLE `hosts_services` ADD PRIMARY KEY(`id`)")
    add_index :hosts_services, :host_id
    add_index :hosts_services, :service_id
    add_index :hosts_services, :user_id
    add_index :hosts_services, :interval_id
    add_index :hosts_services, :status
    add_index :hosts_services, :monitor
    add_index :hosts_services, :enabled
  end
end
