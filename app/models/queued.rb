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
  
  def event_description
    last_status = StatusChange.where(:hosts_service_id => self.hosts_service_id).limit(1).order('created_at DESC')[0]
    self.description = "Host state change was detected on #{host.hostname} IP: #{host.address}.

Test details:

The #{service.name} service status changed from #{last_status.from_status.name} to #{last_status.to_status.name} on #{host.hostname}.
The domain status is #{host.domain.status.name}.

Tested by #{tester.hostname} IP: #{tester.address}"
  end
  
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
    status_change.description = self.description
    status_change.status = self.hosts_service.status

    status_change.save
    DumuzziMailer.warning_message(status_change).deliver
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
