class HostsService < ActiveRecord::Base
  before_create :generate_ids
  belongs_to :host
  belongs_to :service
  belongs_to :status
  belongs_to :interval
  has_many :queueds
  
  def generate_ids
    self.id = Digest::SHA1.hexdigest("#{Socket.gethostname} #{srand.to_s} #{DateTime.now.to_s}")
    self.user_id = self.host.user_id
  end
end
