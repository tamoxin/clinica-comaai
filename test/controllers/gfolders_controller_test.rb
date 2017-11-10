require 'test_helper'

class GfoldersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gfolder = gfolders(:one)
  end

  test "should get index" do
    get gfolders_url
    assert_response :success
  end

  test "should get new" do
    get new_gfolder_url
    assert_response :success
  end

  test "should create gfolder" do
    assert_difference('Gfolder.count') do
      post gfolders_url, params: { gfolder: { group_id: @gfolder.group_id, name: @gfolder.name } }
    end

    assert_redirected_to gfolder_url(Gfolder.last)
  end

  test "should show gfolder" do
    get gfolder_url(@gfolder)
    assert_response :success
  end

  test "should get edit" do
    get edit_gfolder_url(@gfolder)
    assert_response :success
  end

  test "should update gfolder" do
    patch gfolder_url(@gfolder), params: { gfolder: { group_id: @gfolder.group_id, name: @gfolder.name } }
    assert_redirected_to gfolder_url(@gfolder)
  end

  test "should destroy gfolder" do
    assert_difference('Gfolder.count', -1) do
      delete gfolder_url(@gfolder)
    end

    assert_redirected_to gfolders_url
  end
end
