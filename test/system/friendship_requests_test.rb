require "application_system_test_case"

class FriendshipRequestsTest < ApplicationSystemTestCase
  setup do
    @friendship_request = friendship_requests(:one)
  end

  test "visiting the index" do
    visit friendship_requests_url
    assert_selector "h1", text: "Friendship Requests"
  end

  test "creating a Friendship request" do
    visit friendship_requests_url
    click_on "New Friendship Request"

    fill_in "Friend", with: @friendship_request.friend_id
    check "Pending" if @friendship_request.pending
    fill_in "User", with: @friendship_request.user_id
    click_on "Create Friendship request"

    assert_text "Friendship request was successfully created"
    click_on "Back"
  end

  test "updating a Friendship request" do
    visit friendship_requests_url
    click_on "Edit", match: :first

    fill_in "Friend", with: @friendship_request.friend_id
    check "Pending" if @friendship_request.pending
    fill_in "User", with: @friendship_request.user_id
    click_on "Update Friendship request"

    assert_text "Friendship request was successfully updated"
    click_on "Back"
  end

  test "destroying a Friendship request" do
    visit friendship_requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Friendship request was successfully destroyed"
  end
end
