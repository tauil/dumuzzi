class Domain < ActiveRecord::Base
  before_create :generate_ids
  belongs_to :user
  has_many :hosts
  belongs_to :status
  
  def generate_ids
    uuid = UUID.new
    self.id = uuid.generate
  end
end
