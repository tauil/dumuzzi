class ChangeUserId < ActiveRecord::Migration
  def change
=begin  
    remove_column :users, :id
    add_column :users, :id, :string, :first => true, :null => false
    add_index :users, :id
=end
    change_column :users, :id, :string, :null => false, :unique => true
  end
end
