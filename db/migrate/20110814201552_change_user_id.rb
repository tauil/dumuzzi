class ChangeUserId < ActiveRecord::Migration
  def change
    remove_column :users, :id
    add_column :users, :id, :string, :first => true, :null => false
    add_index :users, :id
  end
end
