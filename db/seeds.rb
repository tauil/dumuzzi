
protocol = Protocol.find_by_name('TCP')

ping = Service.create(
  :name => "Ping",
  :protocol => protocol,
  :port => 7,
  :description => "Ping-Pong Echo.",
  :plugin=> "internal_ping",
  :monitor => true,
  :enabled => true
)

http = Service.create(
  :name => "http",
  :protocol => protocol,
  :port => 80,
  :description => "WWW World Wide Web HTTP",
  :plugin=> "internal_http",
  :monitor => true,
  :enabled => true
)

interval = Interval.find(3)
status = Status.find('-2')

user = User.create(:id => Digest::SHA1.hexdigest('monitor'), :email => 'monitor@dumuzzi.com', :password => 'monitor' )

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



