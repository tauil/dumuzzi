class StatusChange < ActiveRecord::Base
  before_create :generate_ids
  belongs_to :host
  belongs_to :hosts_service
  belongs_to :tester, :class_name => 'Host'
  belongs_to :service
  belongs_to :interval
  belongs_to :from_status, :class_name => 'Status'
  belongs_to :to_status, :class_name => 'Status'
  belongs_to :status

  def generate_ids
    uuid = UUID.new
    self.id = uuid.generate
  end

  def make_subject
    subject = "#{service.name} #{to_status.name} on #{host.hostname}"
  end

  def make_description

    description = "Host state change was detected on #{host.hostname} IP: #{host.address}.

Test details:

The #{service.name} service status changed from #{self.from_status.name} to #{self.to_status.name} on #{host.hostname} at #{self.created_at}.
The domain status is #{host.domain.status.name}.

#{self.status.description}

Tested by #{tester.hostname} IP: #{tester.address}"

  end
end
