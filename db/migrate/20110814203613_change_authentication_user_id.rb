class ChangeAuthenticationUserId < ActiveRecord::Migration
  def change    
    change_column :authentications, :user_id, :string, :null => false, :after => :id
    add_index :authentications, :user_id
  end
end
