class HostsService < ActiveRecord::Base
  before_create :generate_ids
  belongs_to :host
  belongs_to :service
  belongs_to :status
  has_many :status_changes
  belongs_to :interval
  has_many :queueds

  def generate_ids
    self.id = Digest::SHA1.hexdigest("#{Socket.gethostname} #{srand.to_s} #{DateTime.now.to_s}")
    self.user_id = self.host.user_id
  end

  def status_changed?
    last_status = StatusChange.where(:hosts_service_id => self.id).limit(1).order('created_at DESC')[0]
    unless last_status.nil?
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
