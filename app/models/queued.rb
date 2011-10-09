require 'net/ping'
require 'net/http'

class Queued < ActiveRecord::Base
  before_create :generate_ids
  belongs_to :host
  belongs_to :service
  belongs_to :hosts_service
  
  def generate_ids
    self.id = Digest::SHA1.hexdigest("#{Socket.gethostname} #{srand.to_s} #{DateTime.now.to_s}")
  end
  
  def internal_ping
    hostname = "#{host.name}.#{host.domain.name}"
    Service::internal_ping(hostname)
  end

  def internal_http_
    hostname = "#{host.name}.#{host.domain.name}"
    Net::Ping::HTTP.new(hostname).ping
  end

  def internal_http
    hostname = "#{host.name}.#{host.domain.name}"
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
