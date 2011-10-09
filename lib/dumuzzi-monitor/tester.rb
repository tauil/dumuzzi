module DumuzziMonitor
  extend self
  
  def tester
    if has_connection?
      puts "[Tester] Starting tests..."
      local_domain = Domain.find_by_name('localdomain')
      local_tester_id = Host.find_by_domain_id(local_domain.id).id
      Queued.where(:tester_id => local_tester_id, :done => false).where(["run_at <= ?", Time.now]).each do |queued|
        puts "[Tester] Testing #{queued.service.name} to #{queued.host.name}.#{queued.host.domain.name} at #{queued.service.protocol.name} port #{queued.service.port}."
        puts "[Tester] Using plugin #{queued.service.plugin}"
        test_resut = eval("queued.#{queued.service.plugin}")
        if test_resut == true
          queued.host.status = true
          queued.hosts_service.status = true
          puts "[Tester] #{queued.service.name} Ok."
        else
          queued.host.status = false
          queued.hosts_service.status = false
  #        DumuzziMailer.warning_message(queued).deliver
          puts "[Tester] #{queued.service.name} Error."
        end
        queued.hosts_service.save
        queued.host.save
        queued.done = true
        queued.save
      end
      puts "[Tester] All tests done."
    else
      puts '[Tester] No network connection available. Tests are disabled.'
    end
  end  
end
