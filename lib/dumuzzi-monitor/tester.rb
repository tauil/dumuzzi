module DumuzziMonitor
  extend self
  
  def tester
    if has_connection?
      puts "[Tester] Starting tests..."
      local_tester_id = Rails.application.config.local_tester[:id]
      Queued.where(:tester_id => local_tester_id, :done => false).where(["run_at <= ?", Time.now]).each do |queued|
      
        puts "[Tester] Testing #{queued.service.name} to #{queued.host.name}.#{queued.host.domain.name} at #{queued.service.protocol.name} port #{queued.service.port}."
        puts "[Tester] Using plugin #{queued.service.plugin}"
        
        test_resut = eval("queued.#{queued.service.plugin}")
        
        if test_resut == true
          status = Status.where(:id => 1)[0]
          queued.done = true
          puts "[Tester] #{queued.service.name} Ok."
        else
          status = Status.where(:id => 0)[0]
          puts "[Tester] #{queued.service.name} Error."
        end
        
#        queued.host.domain.status = status
        queued.host.status = status
        queued.hosts_service.status = status
        
        if queued.hosts_service.status_changed?
          queued.new_status
        end
        
#        queued.host.domain.save
        queued.hosts_service.save
        queued.host.save
        queued.save
      end
      puts "[Tester] All tests done."
    else
      puts '[Tester] No network connection available. Tests are disabled.'
    end
  end  
end
