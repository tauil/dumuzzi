class HomeController < ApplicationController
  def index
    @hosts = Host.where(:status => 1, :enabled => 1).order("name ASC")
    @new_hosts = Host.where(:enabled => 1).order("created_at DESC")
  end
end
