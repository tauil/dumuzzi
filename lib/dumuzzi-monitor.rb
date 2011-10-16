require "#{Dir.pwd}/app/models/host"
require "#{Dir.pwd}/app/models/user"
require "#{Dir.pwd}/app/models/domain"
require "#{Dir.pwd}/app/models/status"
require "#{Dir.pwd}/app/models/hosts_service"
require "#{Dir.pwd}/app/models/service"
require "#{Dir.pwd}/app/models/queued"
require "#{Dir.pwd}/app/models/status_change"
require "#{Dir.pwd}/lib/dumuzzi-monitor/collector"
require "#{Dir.pwd}/lib/dumuzzi-monitor/tester"

module DumuzziMonitor
  extend self
  def has_connection?
    tester = Host.where(:id => Rails.application.config.local_tester[:id])[0]
    unless tester.gateway_state
      puts "[Network] Gateway error. Tests are disabled."
    end
    return tester.gateway_state
  end
  
  def gateway_state_update
    tester = Host.where(:id => Rails.application.config.local_tester[:id])[0]
    return tester.gateway_alive?
  end
end

