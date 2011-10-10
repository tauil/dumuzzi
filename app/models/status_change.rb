class StatusChange < ActiveRecord::Base
  before_create :generate_ids
  belongs_to :host
 
  def generate_ids
    self.id = Digest::SHA1.hexdigest("#{Socket.gethostname} #{srand.to_s} #{DateTime.now.to_s}")
  end
end
