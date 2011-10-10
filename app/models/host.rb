class Host < ActiveRecord::Base
  before_create :generate_ids
  belongs_to :domain
  belongs_to :status
  has_many :hosts_service
  has_many :services, :through => :hosts_service
  has_many :queueds
  has_many :tested, :class_name => 'queued', :primary_key => 'tester_id'
  
  def generate_ids
    self.id = Digest::SHA1.hexdigest("#{Socket.gethostname} #{srand.to_s} #{DateTime.now.to_s}")
    self.user_id = self.domain.user_id
  end
  
  def hostname
    "#{name}.#{domain.name}"
  end
  
  def status_name
    
  end
  
end
