class CreateServices < ActiveRecord::Migration
  def change
    create_table :services, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8', :id => false do |t|
      t.string :uuid, :null => false
      t.string :name, :null => false
      t.string :protocol_id, :null => false
      t.integer :port, :null => false
      t.text :description
      t.string :plugin
      t.boolean :monitor, :default => false
      t.boolean :enabled, :default => false

      t.timestamps
    end
    rename_column :services, :uuid, :id
    ActiveRecord::Base.connection.execute("ALTER TABLE `services` ADD PRIMARY KEY(`id`)")
    add_index :services, :name
    add_index :services, :protocol_id
    add_index :services, :port
    add_index :services, :monitor
    add_index :services, :enabled
  end
end
