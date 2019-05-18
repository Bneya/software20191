require 'test_helper'

class ModrequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @modrequest = modrequests(:one)
  end

  test "should get index" do
    get modrequests_url
    assert_response :success
  end

  test "should get new" do
    get new_modrequest_url
    assert_response :success
  end

  test "should create modrequest" do
    assert_difference('Modrequest.count') do
      post modrequests_url, params: { modrequest: { course_id: @modrequest.course_id, user_id: @modrequest.user_id } }
    end

    assert_redirected_to modrequest_url(Modrequest.last)
  end

  test "should show modrequest" do
    get modrequest_url(@modrequest)
    assert_response :success
  end

  test "should get edit" do
    get edit_modrequest_url(@modrequest)
    assert_response :success
  end

  test "should update modrequest" do
    patch modrequest_url(@modrequest), params: { modrequest: { course_id: @modrequest.course_id, user_id: @modrequest.user_id } }
    assert_redirected_to modrequest_url(@modrequest)
  end

  test "should destroy modrequest" do
    assert_difference('Modrequest.count', -1) do
      delete modrequest_url(@modrequest)
    end

    assert_redirected_to modrequests_url
  end
end
