require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    #@user = User.create(:id => Digest::SHA1.hexdigest('monitor'), :email => 'monitor@dumuzzi.com', :password => 'monitor' )
    @user = users(:homer)
  end

  test "the truth" do
    assert true
  end
  
  test 'should be valid' do
    assert @user, "User shouldn't be created"
  end
  
end
