
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

