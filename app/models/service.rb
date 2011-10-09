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

  def self.gateway_test_ping(hostname)
    puts "Local tester id: #{hostname.id}"
    puts "Gateway: #{hostname.gateway}"
    puts "Testing connection..."
    Net::Ping::External.new(hostname.gateway).ping
  end

end
