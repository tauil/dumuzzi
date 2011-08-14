class Domain < ActiveRecord::Base
  before_create :generate_ids
  has_many :hosts
  
  def generate_ids
    self.id = Digest::SHA1.hexdigest("#{Socket.gethostname} #{srand.to_s} #{DateTime.now.to_s}")
    self.user_id = Digest::SHA1.hexdigest( 'User ' + DateTime.now.to_s)
  end
end
