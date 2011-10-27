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
    self.id = Digest::SHA1.hexdigest("#{Socket.gethostname} #{srand.to_s} #{DateTime.now.to_s}")
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
    if self.internal_ping and self.domain_activate
      puts "Activated host #{host.hostname}"
      hash = Socket.gethostbyname(host.hostname)[3]
      ip = "%d.%d.%d.%d" % [hash[0].ord, hash[1].ord, hash[2].ord, hash[3].ord]
      host.address = ip
      host.enabled = true
    else
      puts "Error activating host #{host.hostname}"
#      host.address = '0.0.0.0'
      host.enabled = false
    end
    host.save
  end

  def domain_activate
    if Service::internal_ping(host.domain.name)
      hash = Socket.gethostbyname(host.domain.name)[3]
      ip = "%d.%d.%d.%d" % [hash[0].ord, hash[1].ord, hash[2].ord, hash[3].ord]
      host.domain.address = ip
      host.domain.enabled = true
    else
      puts "Error activating domain #{host.domain.name}"
#      host.domain.address = '0.0.0.0'
      host.domain.enabled = false    
    end
    host.domain.save
    host.save
  end

  def internal_ping
    hostname = "#{host.hostname}"
    Service::internal_ping(hostname)
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
