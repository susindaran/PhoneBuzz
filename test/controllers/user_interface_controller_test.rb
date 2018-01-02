require 'test_helper'

class UserInterfaceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_interface_index_url
    assert_response :success
  end

end
