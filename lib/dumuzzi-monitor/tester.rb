require "active_record/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "#{Dir.pwd}/app/models/domain"
require "#{Dir.pwd}/app/models/host"
require "#{Dir.pwd}/app/models/hosts_service"
require "#{Dir.pwd}/app/models/service"
require "#{Dir.pwd}/app/models/protocol"
require "#{Dir.pwd}/app/models/queued"
require "#{Dir.pwd}/app/models/status_change"
require "#{Dir.pwd}/app/models/status"
require "#{Dir.pwd}/app/models/interval"
require "#{Dir.pwd}/app/mailers/dumuzzi_mailer"
module DumuzziMonitor
  extend self
  
  def tester
    if has_connection?
      puts "[Tester] Starting tests..."
      local_domain = Domain.find_by_name('localdomain')
      local_tester_id = Host.find_by_domain_id(local_domain.id).id
      Queued.where(:tester_id => local_tester_id, :done => false).where(["run_at <= ?", Time.now]).each do |queued|
        host = queued.host
        domain = host.domain
      
        puts "[Tester] Testing #{queued.service.name} to #{queued.host.name}.#{queued.host.domain.name} at #{queued.service.protocol.name} port #{queued.service.port}."
        puts "[Tester] Using plugin #{queued.service.plugin}"
        test_resut = eval("queued.#{queued.service.plugin}")
        if test_resut == true
          domain.status_id = 1
          queued.host.status_id = 1
          queued.hosts_service.status_id = 1
          queued.event_description
          puts "[Tester] #{queued.service.name} Ok."
        else
          domain.status_id = 0
          queued.host.status_id = 0
          queued.hosts_service.status_id = 0
          queued.event_description
          puts "[Tester] #{queued.service.name} Error."
        end
        
        if queued.hosts_service.status_changed?
          queued.new_status
        end
        
        domain.save
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
