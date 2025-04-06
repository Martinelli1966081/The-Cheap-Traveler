require "test_helper"

class TransportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get transports_index_url
    assert_response :success
  end

  test "should get show" do
    get transports_show_url
    assert_response :success
  end
end
