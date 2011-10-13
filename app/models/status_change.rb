class StatusChange < ActiveRecord::Base
  before_create :generate_ids
  belongs_to :host
  belongs_to :host_service
#  belongs_to :tester
  belongs_to :service
  belongs_to :interval
#  belongs_to :from_status
#  belongs_to :to_status
  belongs_to :status
 
  def generate_ids
    self.id = Digest::SHA1.hexdigest("#{Socket.gethostname} #{srand.to_s} #{DateTime.now.to_s}")
  end
end
