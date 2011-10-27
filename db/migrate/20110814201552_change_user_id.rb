class ChangeUserId < ActiveRecord::Migration
  def change
    change_column :users, :id, :string, :null => false, :unique => true
    add_index :users, :id
  end
end
