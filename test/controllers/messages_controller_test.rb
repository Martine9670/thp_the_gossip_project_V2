require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get messages_index_url
    assert_response :success
  end

  test "should get sent" do
    get messages_sent_url
    assert_response :success
  end
end
