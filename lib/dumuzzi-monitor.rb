require "#{Dir.pwd}/app/models/domain"
require "#{Dir.pwd}/app/models/host"
require "#{Dir.pwd}/app/models/hosts_service"
require "#{Dir.pwd}/app/models/service"
require "#{Dir.pwd}/app/models/protocol"
require "#{Dir.pwd}/app/models/queued"
require "#{Dir.pwd}/app/models/state_change"
require "#{Dir.pwd}/lib/dumuzzi-monitor/collector"
require "#{Dir.pwd}/lib/dumuzzi-monitor/tester"

module DumuzziMonitor
  extend self
def has_connection?(cached=false)
  domain = Domain.find_by_name('localdomain')
  tester = Host.find_by_domain_id(domain)
  unless cached
    unless Service.gateway_test_ping(tester)
      puts "[Network] Gateway error. Tests are disabled."
      tester.gateway_state = false
      tester.save
      return false
    else
      puts "[Network] Gateway OK. Tests are enabled."
      tester.gateway_state = true
      tester.save
      return true
    end
  else
    return tester.gateway_state
  end
end
end

