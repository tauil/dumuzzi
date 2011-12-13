module DumuzziMonitor
  extend self
  
  def activate
    if has_connection?
      domain_activate
      host_activate
    else
      puts '[Collector] No network connection available. Tests are disabled.'
    end     
  end

  def collector
    if has_connection?
      queue
    else
      puts '[Collector] No network connection available. Tests are disabled.'
    end
  end

  def domain_activate

    puts "[Collector] Target Domain Activate."
    service_activate = Service.find_by_plugin('domain_activate')

    puts "[Collector] Collecting host data to activate domains..."
    Domain.where( :monitor => true, :enabled => false).each do |domain|
      puts "[Collector] Found domain #{domain.name}"
      Host.where( :monitor => true, :enabled => false, :tester => false, :is_domain_host => true, :domain_id => domain.id).each do |host|
        puts "[Collector] Opening host #{host.name}.#{domain.name}"
        HostsService.where( :monitor => true, :service_id => service_activate.id, :host_id => host.id).each do |host_service|
          puts "[Collector] Found #{host_service.service.name} at #{host_service.service.protocol.name} port #{host_service.service.port}."
          queued_services = Queued.where(:host_id => host.id, :done => false, :service_id => service_activate.id)
          if queued_services.empty?
            puts "[Collector] Creating job for #{host_service.service.name} to #{host.name}.#{domain.name} at #{host_service.service.protocol.name} port #{host_service.service.port}."
            Queued.create(
              :domain_id => domain.id,
              :host_id => host.id,
              :service_id => service_activate.id,
              :interval_id => host_service.interval_id,
              :hosts_service_id => host_service.id,
              :tester_id => Rails.application.config.local_tester[:id],
              :task_id => 0,
              :done => false,
              :run_at => Time.now
            )
            puts "[Collector] Job queue created."
          else
            puts "[Collector] Skiping job queue creation for #{host.name}.#{domain.name}."
          end
        end
      end
    end
    puts "[Collector] Collect hosts data finished."
  end

  def host_activate

    puts "[Collector] Target Host Activate."
    service_activate = Service.find_by_plugin('host_activate')
      
    puts "[Collector] Collecting host data to populate service jobs..."
    Domain.where( :monitor => true, :enabled => true).each do |domain|
      puts "[Collector] Found domain #{domain.name}"
      Host.where( :monitor => true, :enabled => false, :tester => false, :is_domain_host => false, :domain_id => domain.id).each do |host|
        puts "[Collector] Opening host #{host.name}.#{domain.name}"
        HostsService.where( :monitor => true, :service_id => service_activate.id, :host_id => host.id).each do |host_service|
          puts "[Collector] Found #{host_service.service.name} at #{host_service.service.protocol.name} port #{host_service.service.port}."
          queued_services = Queued.where(:host_id => host.id, :done => false, :service_id => service_activate.id)
          if queued_services.empty?
            puts "[Collector] Creating job for #{host_service.service.name} to #{host.name}.#{domain.name} at #{host_service.service.protocol.name} port #{host_service.service.port}."
            Queued.create(
              :domain_id => domain.id,
              :host_id => host.id,
              :service_id => service_activate.id,
              :interval_id => host_service.interval_id,
              :hosts_service_id => host_service.id,
              :tester_id => Rails.application.config.local_tester[:id],
              :task_id => 0,
              :done => false,
              :run_at => Time.now
            )
            puts "[Collector] Job queue created."
          else
            puts "[Collector] Skiping job queue creation for #{host.name}.#{domain.name}."
          end
        end
      end
    end
    puts "[Collector] Collect hosts data finished."
  end

  def queue
    
    puts "[Collector] Collecting host data to populate service jobs..."
    Domain.where( :monitor => true, :enabled => true).each do |domain|
      puts "[Collector] Found domain #{domain.name}"
      Host.where( :monitor => true, :enabled => true, :tester => false, :domain_id => domain.id).each do |host|
        puts "[Collector] Opening host #{host.name}.#{domain.name}"
        HostsService.where( :monitor => true, :enabled => true, :host_id => host.id).each do |host_service|
          puts "[Collector] Found #{host_service.service.name} at #{host_service.service.protocol.name} port #{host_service.service.port}."
          queued_services = Queued.where(:host_id => host.id, :done => false)
          if queued_services.empty?
            puts "[Collector] Creating job for #{host_service.service.name} to #{host.name}.#{domain.name} at #{host_service.service.protocol.name} port #{host_service.service.port}."
            Queued.create(
              :domain_id => domain.id,
              :host_id => host.id,
              :service_id => host_service.service.id,
              :interval_id => host_service.interval_id,
              :hosts_service_id => host_service.id,
              :tester_id => Rails.application.config.local_tester[:id],
              :task_id => 0,
              :done => false,
              :run_at => Time.now + host_service.interval.value.seconds
            )
            puts "[Collector] Job queue created."
          else
            puts "[Collector] Skiping job queue creation for #{host.name}.#{domain.name}."
          end
        end
      end
    end
    puts "[Collector] Collect hosts data finished."
  end

end
