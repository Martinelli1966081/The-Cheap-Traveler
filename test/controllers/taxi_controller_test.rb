require "test_helper"

class TaxiControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get taxi_index_url
    assert_response :success
  end

  test "should get show" do
    get taxi_show_url
    assert_response :success
  end
end
