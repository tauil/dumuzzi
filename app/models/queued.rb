require 'net/ping'
require 'net/http'

class Queued < ActiveRecord::Base
  before_create :generate_ids
  belongs_to :host
  belongs_to :tester, :class_name => 'Host'
  belongs_to :service
  belongs_to :hosts_service
  belongs_to :interval
  belongs_to :status
  
  def generate_ids
    uuid = UUID.new
    self.id = uuid.generate
  end

  def new_status
    last_status = StatusChange.where(:hosts_service_id => self.hosts_service_id).limit(1).order('created_at DESC')[0]
    if last_status.nil?
      last_status_id = -1
    else
      last_status_id = last_status.status_id
    end
    
    status_change = StatusChange.new
    status_change.host = self.host
    status_change.hosts_service = self.hosts_service
    status_change.tester_id = self.tester_id
    status_change.service = self.service
    status_change.interval = self.interval
    status_change.from_status_id = last_status_id
    status_change.to_status_id = self.hosts_service.status_id
    status_change.make_subject
    status_change.make_description
    status_change.status = self.hosts_service.status
    status_change.save
    
    if self.host.send_alert
      DumuzziMailer.warning_message(status_change).deliver
    end unless self.host.domain.send_alert == false
  end

  def host_activate
    if internal_ping
      puts "Activated host #{host.hostname}"
      hash = Socket.gethostbyname(host.hostname)[3]
      ip = "%d.%d.%d.%d" % [hash[0].ord, hash[1].ord, hash[2].ord, hash[3].ord]
      host.address = ip
      host.enabled = true
      host.status_id = -2
      hosts_service.status_id = -2
      hosts_service.save
      host.save
      return true
    else
      puts "Error activating host #{host.hostname}"
      host.address = '0.0.0.0'
      host.enabled = false
      host.status_id = 2
      hosts_service.status_id = 2
      hosts_service.save
      host.save
      return false
    end
  end

  def domain_activate
    if internal_domain_ping
      puts "Activated domain #{host.domain.name}"
      hash = Socket.gethostbyname(host.domain.name)[3]
      ip = "%d.%d.%d.%d" % [hash[0].ord, hash[1].ord, hash[2].ord, hash[3].ord]
      host.domain.address = ip
      host.domain.enabled = true
      host.domain.status_id = -2
      host.domain.save
      return true
    else
      puts "Error activating domain #{host.domain.name}"
      host.domain.address = '0.0.0.0'
      host.domain.enabled = false    
      host.domain.status_id = 2
      host.domain.save
      return false
    end
  end

  def internal_domain_ping
    puts ">>>> #{host.domain.name}"
    Service::internal_ping(host.domain.name)
  end

  def internal_ping
    Service::internal_ping(host.hostname)
  end

  def internal_http_
    hostname = "#{host.hostname}"
    Net::Ping::HTTP.new(hostname).ping
  end

  def internal_http
    hostname = "#{host.hostname}"
    begin
      Net::HTTP.start(hostname) do |http|
        response = http.get('/')
        if not response.code.match(/200/)
          puts "Web Server down or not resonding: #{response.code} #{response.message}"
        else
          true
        end
      end
    rescue SocketError => socket_error
      puts "Error Connecting To Web: #{socket_error}"
    rescue TimeoutError => timeout_error
      puts "Web connection timed out: #{timeout_error}"
    end    
  end

end
