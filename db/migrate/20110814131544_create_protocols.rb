class CreateProtocols < ActiveRecord::Migration
  def change
    create_table :protocols, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8', :id => false do |t|
      t.string :uuid, :null => false
      t.string :name, :null => false
      t.boolean :enabled, :default => false

      t.timestamps
    end
    rename_column :protocols, :uuid, :id
    ActiveRecord::Base.connection.execute("ALTER TABLE `protocols` ADD PRIMARY KEY(`id`)")
    Protocol.create(:name => 'TCP', :enabled => true)
    Protocol.create(:name => 'UDP', :enabled => true)
  end
end
