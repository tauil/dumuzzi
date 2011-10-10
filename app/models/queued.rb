require 'net/ping'
require 'net/http'

class Queued < ActiveRecord::Base
  before_create :generate_ids
  belongs_to :host
  belongs_to :tester, :class_name => :host, :foreign_key => :tester_id
  belongs_to :service
  belongs_to :hosts_service
  
  def event_description
    self.description = "Host stage change detected on #{host.hostname}.
The host status change to #{host.status}.
The domain status change to #{host.domain.status}.
Test by {ID}"
  end
  
  def generate_ids
    self.id = Digest::SHA1.hexdigest("#{Socket.gethostname} #{srand.to_s} #{DateTime.now.to_s}")
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
