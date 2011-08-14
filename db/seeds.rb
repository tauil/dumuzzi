# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

user_id = Digest::SHA1.hexdigest('monitor')
domains = [ 'localdomain', 'actiohost.com', 'cidadelas.com.br', 'koshtech.com', 'familiakosh.org', 'google.com',]

domains.each do |domain| 
  Domain.create( :name => domain, 
    :user_id => user_id, 
    :enabled => true, 
    :monitor => true
  )
end

hostnames = [ 'www' ]

hostnames.each do |hostname|
  Domain.all.each do |domain|
    Host.create(
      :domain_id => domain.id,
      :user_id => domain.user_id,
      :name => hostname, 
      :enabled => true, 
      :monitor => true
    )
  end
end

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

=begin
Service.create(
  :name => "",
  :protocol_id  => 0,
  :port => 0"",
  :description => "",
  :plugin=> "",
  :status => 1,
  :monitor => true,
  :enabled => true
)
=end

host = Host.find_by_domain_id(Domain.find_by_name('localdomain'))
host.name = 'localhost'
host.monitor = false
host.save

service = Service.find_by_name('Ping')
host = Host.find_by_domain_id(Domain.find_by_name('koshtech.com'))

HostsService.create(:host => host, :service => service, :user_id => host.user_id, :interval_id => 60)

