class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8', :id => false do |t|
      t.string :uuid, :null => false
      t.integer :category, :null => false, :default => 0 # 0 Invalid/ 1 Master/ 2 Node/ 3 Tester/ 4 Partner/ 5 User
      t.string :user_id, :null => false
      t.string :name, :null => false
      t.string :address
      t.text :description
      t.boolean :allow_comments, :default => false
      t.boolean :send_alert, :default => false
      t.boolean :share, :default => false
      t.integer :status, :default => -1, :null => false
      t.boolean :monitor, :default => false
      t.boolean :enabled, :default => false

      t.timestamps
    end
    rename_column :domains, :uuid, :id
    ActiveRecord::Base.connection.execute("ALTER TABLE `domains` ADD PRIMARY KEY(`id`)")
    add_index :domains, :category
    add_index :domains, :name, :unique => true
    add_index :domains, :user_id
    add_index :domains, :address
    add_index :domains, :allow_comments
    add_index :domains, :send_alert
    add_index :domains, :share
    add_index :domains, :status
    add_index :domains, :monitor
    add_index :domains, :enabled
  end
end
