class Host < ActiveRecord::Base
  before_create :generate_ids
  belongs_to :domain
  has_many :hosts_service
  has_many :services, :through => :hosts_service
  belongs_to :queueds
  
  def generate_ids
    self.id = Digest::SHA1.hexdigest("#{Socket.gethostname} #{srand.to_s} #{DateTime.now.to_s}")
    self.user_id = self.domain.user_id
  end
end
