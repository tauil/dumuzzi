class CreateQueueds < ActiveRecord::Migration
  def change
    create_table :queueds, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8', :id => false do |t|
      t.string :uuid, :null => false
      t.string :host_id, :null => false
      t.string :service_id, :null => false
      t.string :hosts_service_id, :null => false
      t.string :interval_id, :null => false
      t.string :tester_id, :null => false
      t.string :task_id, :null => false
      t.integer :status, :default => -1
      t.boolean :done, :default => false
      t.datetime :run_at, :null => false

      t.timestamps
    end
    rename_column :queueds, :uuid, :id
    ActiveRecord::Base.connection.execute("ALTER TABLE `queueds` ADD PRIMARY KEY(`id`)")
    add_index :queueds, :host_id
    add_index :queueds, :service_id
    add_index :queueds, :interval_id
    add_index :queueds, :tester_id
    add_index :queueds, :task_id
    add_index :queueds, :status
    add_index :queueds, :done
    add_index :queueds, :run_at
  end
end
