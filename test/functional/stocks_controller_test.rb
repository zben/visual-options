require 'test_helper'

class StocksControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get options" do
    get :options
    assert_response :success
  end

  test "should get sma" do
    get :sma
    assert_response :success
  end

end
