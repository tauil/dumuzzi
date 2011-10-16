class AddAditionalStatuses < ActiveRecord::Migration
  def change
    ActiveRecord::Base.connection.execute("INSERT INTO statuses 
      (id, name, description, action, enabled, created_at, updated_at) VALUES 
      (-3, 'Gateway Down', 'The gateway are now unreachable. All tests are stoped. :-(', 'notify', 1, '#{DateTime.now}', NULL)")
    ActiveRecord::Base.connection.execute("INSERT INTO statuses       
      (id, name, description, action, enabled, created_at, updated_at) VALUES 
      (-2, 'Initialized', 'Service check for host initialized. Tests are not applicable.', 'notify', 1, '#{DateTime.now}', NULL)")
    ActiveRecord::Base.connection.execute("INSERT INTO statuses 
      (id, name, description, action, enabled, created_at, updated_at) VALUES 
      (2, 'Timeout', 'Service timeout. It is not mean the host are down, but the connection was timeout.', 'notify', 1, '#{DateTime.now}', NULL)")
  end
end
