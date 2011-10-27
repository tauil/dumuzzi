class Protocol < ActiveRecord::Base
  before_create :generate_ids
  has_many :services
 
  def generate_ids
    uuid = UUID.new
    self.id = uuid.generate
  end
end
