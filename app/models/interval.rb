class Interval < ActiveRecord::Base
  has_many :hosts_services
  has_many :queueds
  has_many :intervals
end
