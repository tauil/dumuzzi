class ChangeAuthenticationUserId < ActiveRecord::Migration
  def change
    remove_column :authentications, :user_id
    add_column :authentications, :user_id, :string, :after => :id, :null => false
    add_index :authentications, :user_id
  end
end
