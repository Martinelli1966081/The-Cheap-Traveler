require "test_helper"

class StaysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stays_index_url
    assert_response :success
  end

  test "should get show" do
    get stays_show_url
    assert_response :success
  end
end
