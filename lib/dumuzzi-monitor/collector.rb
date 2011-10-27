module DumuzziMonitor
  extend self
  
  def activate
    if has_connection?
      queue(:domain_activate)
    else
      puts '[Collector] No network connection available. Tests are disabled.'
    end     
  end

  def collector(target = :host_service)
    if has_connection?
      queue(target)
    else
      puts '[Collector] No network connection available. Tests are disabled.'
    end
  end

  def queue(target = :host_service)
    service_host_activate_id = Service.find_by_plugin('host_activate').id
    enabled = true
    if target == :host_activate
      puts "[Collector] Target #{target}."
      sql_where = "= '#{service_host_activate_id}'"
      enabled = false
    elsif target == :host_service
      puts "[Collector] Target #{target}."
      sql_where = "<> '#{service_host_activate_id}'"
    else
      puts "[Collector] Error. Unknow target."
      return false
    end
    puts "[Collector] Collecting host data to populate service jobs..."
    Domain.where( :monitor => true, :enabled => enabled).each do |domain|
      puts "[Collector] Found domain #{domain.name}"
      Host.where( :monitor => true, :enabled => enabled, :tester => false, :domain_id => domain.id).each do |host|
        puts "[Collector] Opening host #{host.name}.#{domain.name}"
        HostsService.where( :monitor => true, :enabled => true, :host_id => host.id).where("service_id #{sql_where}").each do |host_service|
          puts "[Collector] Found #{host_service.service.name} at #{host_service.service.protocol.name} port #{host_service.service.port}."
          queued_services = Queued.where(:host_id => host.id, :done => false).where("service_id #{sql_where}")
          if queued_services.empty?
            puts "[Collector] Creating job for #{host_service.service.name} to #{host.name}.#{domain.name} at #{host_service.service.protocol.name} port #{host_service.service.port}."
            Queued.create(
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
