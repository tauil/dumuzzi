class Domain < ActiveRecord::Base
  before_create :generate_ids
  after_create :activate
  belongs_to :user
  has_many :hosts
  has_many :hosts_services
  belongs_to :status
  
  def generate_ids
    uuid = UUID.new
    self.id = uuid.generate
  end
  
  def activate
    host_activate = Service.find_by_plugin('domain_activate')
    interval = Interval.find_by_value('600')
    status = Status.find_by_name('Initialized')
    host = Host.create(
      :domain => self,
      :user => self.user,
      :name => '@', 
      :enabled => false,
      :monitor => true,
      :tester => false,
      :is_domain_host => true,
      :gateway => '0.0.0.0'
    )
    host.hosts_service.create(
      :domain_id => self,
      :host => host,
	    :service => host_activate,
    	:user => self.user,
	    :interval => interval,
	    :description =>	host_activate.description,
	    :status => status,
	    :monitor => true,
	    :enabled => true
	  )
    
  end
end
