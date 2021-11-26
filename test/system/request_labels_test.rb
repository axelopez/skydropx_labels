require "application_system_test_case"

class RequestLabelsTest < ApplicationSystemTestCase
  setup do
    @request_label = request_labels(:one)
  end

  test "visiting the index" do
    visit request_labels_url
    assert_selector "h1", text: "Request Labels"
  end

  test "creating a Request label" do
    visit request_labels_url
    click_on "New Request Label"

    fill_in "Reference", with: @request_label.reference
    fill_in "Request", with: @request_label.request
    fill_in "Status", with: @request_label.status
    fill_in "Token", with: @request_label.token_id
    click_on "Create Request label"

    assert_text "Request label was successfully created"
    click_on "Back"
  end

  test "updating a Request label" do
    visit request_labels_url
    click_on "Edit", match: :first

    fill_in "Reference", with: @request_label.reference
    fill_in "Request", with: @request_label.request
    fill_in "Status", with: @request_label.status
    fill_in "Token", with: @request_label.token_id
    click_on "Update Request label"

    assert_text "Request label was successfully updated"
    click_on "Back"
  end

  test "destroying a Request label" do
    visit request_labels_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Request label was successfully destroyed"
  end
end
