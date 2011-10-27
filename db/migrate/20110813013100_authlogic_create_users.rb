class AuthlogicCreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :name
      t.string    :login,               :unique => true
      t.string    :email,               :unique => true
      t.string    :crypted_password
      t.string    :password_salt
      t.string    :persistence_token
      t.string    :single_access_token
      t.string    :perishable_token

      t.integer   :login_count,         :default => 0
      t.integer   :failed_login_count,  :default => 0
      t.datetime  :last_request_at
      t.datetime  :current_login_at
      t.datetime  :last_login_at
      t.string    :current_login_ip
      t.string    :last_login_ip
      
      t.boolean   :published,           :default => false
      t.datetime  :published_at
      t.boolean   :enabled,             :default => true
      t.datetime  :deleted_at
      t.string    :avatar_url
      t.boolean   :can_login,           :default => false
      t.boolean   :delta,               :default => true
      t.boolean   :vip,                 :default => false

      t.timestamps
    end
    
    add_index :users, :email,           :unique => true
    add_index :users, :name
    add_index :users, :login,           :unique => true
    
    User.create(
      :name => 'Super User',
      :login => 'dumuzzi',
      :email => 'admin@dumuzzi.com',
      :password => 'dumuzzi2011',
      :password_confirmation => 'dumuzzi2011',
      :published => true,
      :published_at => Time.now,
      :enabled => true,
      :can_login => true,
      :vip => true
    )
    
    sleep 1
        
    User.create(
      :name => 'Visitante',
      :login => 'guest',
      :email => 'guest@koshtech.com.br',
      :password => 'L06inD1sa8l3dBYadmin',
      :password_confirmation => 'L06inD1sa8l3dBYadmin',
      :published => true,
      :published_at => Time.now,
      :enabled => true,
      :can_login => false,
      :vip => false
    )
  end

  def self.down
    drop_table :users
  end
end
