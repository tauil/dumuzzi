
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
  :description => "www WorldWideWeb HTTP",
  :plugin=> "internal_http",
  :monitor => true,
  :enabled => true
)

interval = Interval.find(3)
status = Status.find('-2')

user = User.create(:id => Digest::SHA1.hexdigest('monitor'), :email => 'monitor@dumuzzi.com', :password => 'monitor' )

domains = [ 'dumuzzi.com']
hostnames = [ 'tester1', 'tester2' ]

domains.each do |domain| 
  domain = Domain.create( :name => domain, 
    :user => user, 
    :enabled => true, 
    :monitor => true
  )
  hostnames.each do |hostname|
    host = Host.create(
      :domain => domain,
      :user => domain.user,
      :name => hostname, 
      :enabled => true, 
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
	    :enabled => true
	  )
  end
end



