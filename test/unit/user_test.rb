require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.create(:user_id => Digest::SHA1.hexdigest('monitor'), :email => 'monitor@dumuzzi.com', :password => 'monitor' )
  end

  test "the truth" do
    assert true
  end
  
  test 'should be valid' do
    assert @user, "User shouldn't be created"
  end
  
end
