require 'test_helper'

class RoomControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get party" do
    get :party
    assert_response :success
  end

end
