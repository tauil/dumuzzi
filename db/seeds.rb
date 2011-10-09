
protocol = Protocol.find_by_name('TCP')

Service.create(
  :name => "Ping",
  :protocol => protocol,
  :port => 7,
  :description => "Ping-Pong Echo.",
  :plugin=> "internal_ping",
  :monitor => true,
  :enabled => true
)

Service.create(
  :name => "http",
  :protocol => protocol,
  :port => 80,
  :description => "www WorldWideWeb HTTP",
  :plugin=> "internal_http",
  :monitor => true,
  :enabled => true
)

user = User.create(:user_id => Digest::SHA1.hexdigest('monitor'), :email => 'monitor@dumuzzi.com', :password => Digest::SHA1.hexdigest('monitor') )

domains = [ 'localdomain']

domains.each do |domain| 
  Domain.create( :name => domain, 
    :user_id => user.id, 
    :enabled => true, 
    :monitor => true
  )
end

hostnames = [ 'localhost' ]

hostnames.each do |hostname|
  Domain.all.each do |domain|
    Host.create(
      :domain_id => domain.id,
      :user_id => domain.user_id,
      :name => hostname, 
      :enabled => true, 
      :monitor => true,
      :tester => true,
      :gateway => '0.0.0.0'
    )
  end
end

