class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8', :id => false do |t|
      t.integer :id, :null => false
      t.string :name, :null => false
      t.text :description
      t.string :action, :null => false
      t.boolean :enabled, :default => false

      t.timestamps
    end
    ActiveRecord::Base.connection.execute("ALTER TABLE `statuses` ADD PRIMARY KEY(`id`)")
    add_index :statuses, :id
    add_index :statuses, :name
    add_index :statuses, :action
    add_index :statuses, :enabled
    
    ActiveRecord::Base.connection.execute("INSERT INTO statuses 
      (id, name, description, action, enabled, created_at, updated_at) VALUES 
      (-1, 'Not tested yet', 'Host not tested yet.', 'notify', 1, '#{DateTime.now}', NULL)")
    ActiveRecord::Base.connection.execute("INSERT INTO statuses 
      (id, name, description, action, enabled, created_at, updated_at) VALUES 
      (0, 'Offline', 'Host offline or unreachable.', 'notify', 1, '#{DateTime.now}', NULL)")
    ActiveRecord::Base.connection.execute("INSERT INTO statuses 
      (id, name, description, action, enabled, created_at, updated_at) VALUES 
      (1, 'Online', 'Host online.', 'notify', 1, '#{DateTime.now}', NULL)")
  end
end
