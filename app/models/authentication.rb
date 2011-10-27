class Authentication < ActiveRecord::Base
  before_create :generate_ids
  belongs_to :user
  
  #validates_presence_of :user_id, :uid, :provider
  #validates_uniqueness_of :uid, :scope => :provider

  def generate_ids
    self.id = Digest::SHA1.hexdigest("#{Socket.gethostname} #{srand.to_s} #{DateTime.now.to_s}")
  end

  def provider_name
    if provider == 'open_id'
      "OpenID"
    else
      provider.titleize
    end
  end
end
