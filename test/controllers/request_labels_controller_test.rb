require "test_helper"

class RequestLabelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @request_label = request_labels(:one)
  end

  test "should get index" do
    get request_labels_url
    assert_response :success
  end

  test "should get new" do
    get new_request_label_url
    assert_response :success
  end

  test "should create request_label" do
    assert_difference('RequestLabel.count') do
      post request_labels_url, params: { request_label: { reference: @request_label.reference, request: @request_label.request, status: @request_label.status, token_id: @request_label.token_id } }
    end

    assert_redirected_to request_label_url(RequestLabel.last)
  end

  test "should show request_label" do
    get request_label_url(@request_label)
    assert_response :success
  end

  test "should get edit" do
    get edit_request_label_url(@request_label)
    assert_response :success
  end

  test "should update request_label" do
    patch request_label_url(@request_label), params: { request_label: { reference: @request_label.reference, request: @request_label.request, status: @request_label.status, token_id: @request_label.token_id } }
    assert_redirected_to request_label_url(@request_label)
  end

  test "should destroy request_label" do
    assert_difference('RequestLabel.count', -1) do
      delete request_label_url(@request_label)
    end

    assert_redirected_to request_labels_url
  end
end
