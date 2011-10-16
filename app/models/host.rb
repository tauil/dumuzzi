class Host < ActiveRecord::Base
  before_create :generate_ids
  belongs_to :user
  belongs_to :domain
  belongs_to :status
  has_many :hosts_service
  has_many :services, :through => :hosts_service
  has_many :queueds
  has_many :tested, :class_name => 'queued', :primary_key => 'tester_id'
  has_many :status_changes
  
  def generate_ids
    self.id = Digest::SHA1.hexdigest("#{Socket.gethostname} #{srand.to_s} #{DateTime.now.to_s}")
    self.user_id = self.domain.user_id
  end
  
  def hostname
    "#{name}.#{domain.name}"
  end

  def gateway_alive?
    self.gateway = Rails.application.config.local_tester[:gateway]
    puts "[Network] Local tester id: #{hostname}"
    puts "[Network] Gateway: #{hostname}"
    puts "[Network] Testing connection..."
    unless Net::Ping::External.new(gateway).ping
      puts "[Network] Gateway error. Tests are disabled."
      self.gateway_state = false
      self.save
      return false
    else
      puts "[Network] Gateway OK. Tests are enabled."
      self.gateway_state = true
      self.save
      return true
    end
  end

  def status_changed?
    last_status = StatusChange.where(:host_id => self.id).limit(1).order('created_at DESC')
    unless last_status.empty?
      unless last_status.status_id == self.status_id
        true
      else
        false
      end
    else
      true
    end
  end
  
end
