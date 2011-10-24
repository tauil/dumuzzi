class HomeController < ApplicationController
  def index
    @hosts = Host.where(:status_id => 1, :enabled => 1, :share => true, :tester => false).where("created_at < '#{(Time.now - 7.days)}'").order("created_at DESC")
    @new_hosts = Host.where(:enabled => 1, :share => true, :tester => false).where("created_at > '#{DateTime.now - 7.days}'").where("id NOT IN ('#{@hosts.map(&:id).join(',')}')").order("created_at DESC")
    @testers = Host.where(:enabled => 1, :tester => true).order("created_at DESC")
  end
end
