class AddServicesFields < ActiveRecord::Migration
  def change
    add_column :services, :public, :boolean, :defaut => true
    add_index :services, :public
    
    Service.all.each do |service|
      service.public = (service.plugin == "host_activate") ? false : true
      service.save
    end
    
    unless Service.find_by_plugin("host_activate")
      Service.create(
        :name => "Host Activate",
        :protocol => Protocol.find_by_name('TCP'),
        :port => 7,
        :description => "Host activation test service. Will test and activate the host test.",
        :plugin => "host_activate",
        :public => false,
        :monitor => true,
        :enabled => true
      )
    end
  end
end
