class User < ActiveRecord::Base
  before_create :generate_ids
  has_many :authentications
  has_many :domains
  has_many :hosts
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def generate_ids
    self.id = Digest::SHA1.hexdigest("#{Socket.gethostname} #{srand.to_s} #{DateTime.now.to_s}")
  end

  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email'] if email.blank?
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end
  
  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
end
