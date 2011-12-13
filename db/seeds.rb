
protocol = Protocol.find_by_name('TCP')

ping = Service.create(
  :name => "Ping",
  :protocol => protocol,
  :port => 7,
  :description => "Ping-Pong Echo.",
  :plugin=> "internal_ping",
  :public => true,
  :monitor => true,
  :enabled => true
)

http = Service.create(
  :name => "http",
  :protocol => protocol,
  :port => 80,
  :description => "WWW World Wide Web HTTP",
  :plugin=> "internal_http",
  :public => true,
  :monitor => true,
  :enabled => true
)

unless Service.find_by_plugin("host_activate")
  Service.create(
    :name => "Host Activate",
    :protocol => Protocol.find_by_name('TCP'),
    :port => 7,
    :description => "Host activation test service. Will test and activate the host test.",
    :plugin => "host_activate",
    :public => false,
    :monitor => true,
    :enabled => true
  )
end

unless Service.find_by_plugin("domain_activate")
  Service.create(
    :name => "Domain Activate",
    :protocol => Protocol.find_by_name('TCP'),
    :port => 7,
    :description => "Domain activation test service. Will test and activate the domain for tests.",
    :plugin => "domain_activate",
    :public => false,
    :monitor => true,
    :enabled => true
  )
end

interval = Interval.find(3)
status = Status.find('-2')

uuid = UUID.new
user = User.create(:id => uuid.generate, :email => 'monitor@dumuzzi.com', :password => 'monitor' )
user = User.find_by_email('admin@dumuzzi.com')

domains = [ 'dumuzzi.com']
hostnames = [ 'rally', 'us-ut-1', 'us-fl-1', 
              'br-rj-1', 'br-rj-2', 'br-sp-1' ]
domains.each do |domain|
 
  domain = Domain.create( :name => domain, 
    :user => user, 
    :enabled => true, 
    :monitor => true
  )
  hostnames.each do |hostname|
  
    if hostname == 'rally'
      enabled = true
    else
      enabled = false
    end
    
    host = Host.create(
      :domain => domain,
      :user => domain.user,
      :name => hostname, 
      :enabled => enabled, 
      :monitor => true,
      :tester => true,
      :gateway => '0.0.0.0'
    )
    host.hosts_service.create(
      :domain => domain,
      :host => host,
	    :service => ping,
    	:user => user,
	    :interval => interval,
	    :description =>	"#{ping.name} Test. #{ping.description}",
	    :status => status,
	    :monitor => true,
	    :enabled => enabled
	  )
  end
end



