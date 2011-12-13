class NewFields < ActiveRecord::Migration
  def change
    add_column :hosts, :is_domain_host, :boolean, :default => false
    add_column :hosts_services, :domain_id, :integer, :null => false
    add_column :queueds, :domain_id, :integer, :null => false
    add_column :users, :is_admin, :boolean, :default => false

    user = User.find_by_email('admin@dumuzzi.com')
    user.is_admin = true
    user.save

    unless Service.find_by_plugin("domain_activate")
      Service.create(
        :name => "Domain Activate",
        :protocol => Protocol.find_by_name('TCP'),
        :port => 7,
        :description => "Domain activation test service. Will test and activate the domain for tests.",
        :plugin => "domain_activate",
        :public => false,
        :monitor => true,
        :enabled => true
      )
    end

    HostsService.all.each do |host_service|
      host_service.domain = host_service.host.domain
      host_service.save
    end

    Queued.all.each do |queued|
      queued.domain = queued.host.domain
      queued.save
    end

    Domain.all.each do |domain|
      domain.activate
    end
    
  end
end
