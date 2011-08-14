class CreateStateChanges < ActiveRecord::Migration
  def change
    create_table :state_changes, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8', :id => false do |t|
      t.string :uuid, :null => false
      t.string :host_id, :null => false
      t.string :tester_id, :null => false
      t.string :service_id, :null => false
      t.string :interval_id, :null => false
      t.integer :from_status, :null => false
      t.integer :to_status, :null => false
      t.text :description
      t.integer :status, :default => 0

      t.timestamps
    end
    rename_column :state_changes, :uuid, :id
    ActiveRecord::Base.connection.execute("ALTER TABLE `state_changes` ADD PRIMARY KEY(`id`)")
    add_index :state_changes, :host_id
    add_index :state_changes, :tester_id
    add_index :state_changes, :service_id
    add_index :state_changes, :interval_id
    add_index :state_changes, :from_status
    add_index :state_changes, :to_status
    add_index :state_changes, :status
  end
end
