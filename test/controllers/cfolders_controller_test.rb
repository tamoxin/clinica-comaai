require 'test_helper'

class CfoldersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cfolder = cfolders(:one)
  end

  test "should get index" do
    get cfolders_url
    assert_response :success
  end

  test "should get new" do
    get new_cfolder_url
    assert_response :success
  end

  test "should create cfolder" do
    assert_difference('Cfolder.count') do
      post cfolders_url, params: { cfolder: { course_id: @cfolder.course_id, name: @cfolder.name } }
    end

    assert_redirected_to cfolder_url(Cfolder.last)
  end

  test "should show cfolder" do
    get cfolder_url(@cfolder)
    assert_response :success
  end

  test "should get edit" do
    get edit_cfolder_url(@cfolder)
    assert_response :success
  end

  test "should update cfolder" do
    patch cfolder_url(@cfolder), params: { cfolder: { course_id: @cfolder.course_id, name: @cfolder.name } }
    assert_redirected_to cfolder_url(@cfolder)
  end

  test "should destroy cfolder" do
    assert_difference('Cfolder.count', -1) do
      delete cfolder_url(@cfolder)
    end

    assert_redirected_to cfolders_url
  end
end
