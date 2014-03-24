require 'test_helper'

class Admin::CustomersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
