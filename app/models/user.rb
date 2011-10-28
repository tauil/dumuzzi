class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.ignore_blank_passwords = true #ignoring passwords
    c.validate_password_field = false #ignoring validations for password fields
    c.validate_email_field = false
  end

  before_create :generate_ids
  attr_accessor :password_confirmation
  has_many :authentications
  has_many :domains
  has_many :hosts
  has_many :hosts_services

  def generate_ids
    uuid = UUID.new
    self.id = uuid.generate
  end
  
  def self.find_by_login_or_email(login)
    find_by_login(login) || find_by_email(login)
  end

  def apply_omniauth(omniauth)
    #self.email = omniauth['user_info']['email'] if email.blank?
    self.login = omniauth['user_info']['nickname']
    self.name = omniauth['user_info']['name']
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end
  
  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
end

