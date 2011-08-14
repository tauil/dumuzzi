class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8', :id => false do |t|
      t.string :uuid, :null => false
      t.integer :category, :null => false, :default => 0 # 0 Invalid/ 1 Master/ 2 Node/ 3 Tester/ 4 Partner/ 5 User
      t.string :user_id, :null => false
      t.string :domain_id, :null => false
      t.string :name, :null => false
      t.string :address
      t.text :description
      t.boolean :tester, :default => false
      t.boolean :allow_comments, :default => false
      t.boolean :send_alert, :default => false
      t.boolean :share, :default => false
      t.integer :status, :default => -1
      t.boolean :monitor, :default => false
      t.boolean :enabled, :default => false

      t.timestamps
    end
    rename_column :hosts, :uuid, :id
    ActiveRecord::Base.connection.execute("ALTER TABLE `hosts` ADD PRIMARY KEY(`id`)")
    add_index :hosts, :category
    add_index :hosts, :name
    add_index :hosts, :user_id
    add_index :hosts, :domain_id
    add_index :hosts, :address
    add_index :hosts, :allow_comments
    add_index :hosts, :send_alert
    add_index :hosts, :share
    add_index :hosts, :status
    add_index :hosts, :monitor
    add_index :hosts, :enabled
  end
end
