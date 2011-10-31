class AddingExtraFields < ActiveRecord::Migration
  def up
    add_column :domains, :published, :boolean
    add_column :domains, :published_at, :datetime
    add_column :domains, :deleted_at, :datetime
    
    add_column :hosts, :published, :boolean
    add_column :hosts, :published_at, :datetime
    add_column :hosts, :deleted_at, :datetime
    
    add_column :hosts_services, :deleted_at, :datetime
    
    add_column :intervals, :published, :boolean
    add_column :intervals, :published_at, :datetime
    add_column :intervals, :deleted_at, :datetime
    
    add_column :protocols, :published, :boolean
    add_column :protocols, :published_at, :datetime
    add_column :protocols, :deleted_at, :datetime
    
    add_column :queueds, :published, :boolean
    add_column :queueds, :published_at, :datetime
    add_column :queueds, :enabled, :boolean
    add_column :queueds, :deleted_at, :datetime
    
    add_column :services, :published, :boolean
    add_column :services, :published_at, :datetime
    add_column :services, :deleted_at, :datetime
    
    add_column :statuses, :published, :boolean
    add_column :statuses, :published_at, :datetime
    add_column :statuses, :deleted_at, :datetime
    
    add_column :status_changes, :published, :boolean
    add_column :status_changes, :published_at, :datetime
    add_column :status_changes, :enabled, :boolean
    add_column :status_changes, :deleted_at, :datetime
    
    add_index :domains, :published
    add_index :hosts, :published
    add_index :intervals, :published
    add_index :protocols, :published
    add_index :queueds, :published
    add_index :services, :published
    add_index :statuses, :published
    add_index :status_changes, :published
  end
end
