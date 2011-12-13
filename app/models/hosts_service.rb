class HostsService < ActiveRecord::Base
  before_create :generate_ids
  after_create :initialize_status
  belongs_to :user
  belongs_to :domain
  belongs_to :host
  belongs_to :service
  belongs_to :status
  has_many :status_changes
  belongs_to :interval
  has_many :queueds

  def generate_ids
    uuid = UUID.new
    self.id = uuid.generate
    self.user_id = self.host.user_id
  end

  def initialize_status
    initialized_status = Status.where(:id => -2)[0]
    not_tested_status = Status.where(:id => -1)[0]
  
    status_change = StatusChange.new
    status_change.host = self.host
    status_change.hosts_service = self
    status_change.tester_id = Rails.application.config.local_tester[:id]
    status_change.service = self.service
    status_change.interval = self.interval
    status_change.from_status = initialized_status
    status_change.to_status = not_tested_status
    status_change.description = "Status initialized."
    status_change.status = not_tested_status
    status_change.save
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
