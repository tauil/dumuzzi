require 'net/ping'
require 'net/http'
class Service < ActiveRecord::Base
  before_create :generate_ids
  belongs_to :protocol
  has_many :hosts_service
  has_many :hosts, :through => :host_services
  has_many :queueds

  def generate_ids
    self.id = Digest::SHA1.hexdigest("#{Socket.gethostname} #{srand.to_s} #{DateTime.now.to_s}")
  end

  def self.internal_ping(hostname)
    Net::Ping::External.new(hostname).ping
  end

end
