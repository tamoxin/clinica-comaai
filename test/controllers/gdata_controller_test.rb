require 'test_helper'

class GdataControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gdatum = gdata(:one)
  end

  test "should get index" do
    get gdata_url
    assert_response :success
  end

  test "should get new" do
    get new_gdatum_url
    assert_response :success
  end

  test "should create gdatum" do
    assert_difference('Gdatum.count') do
      post gdata_url, params: { gdatum: { body: @gdatum.body, gfolder_id: @gdatum.gfolder_id, link: @gdatum.link, title: @gdatum.title } }
    end

    assert_redirected_to gdatum_url(Gdatum.last)
  end

  test "should show gdatum" do
    get gdatum_url(@gdatum)
    assert_response :success
  end

  test "should get edit" do
    get edit_gdatum_url(@gdatum)
    assert_response :success
  end

  test "should update gdatum" do
    patch gdatum_url(@gdatum), params: { gdatum: { body: @gdatum.body, gfolder_id: @gdatum.gfolder_id, link: @gdatum.link, title: @gdatum.title } }
    assert_redirected_to gdatum_url(@gdatum)
  end

  test "should destroy gdatum" do
    assert_difference('Gdatum.count', -1) do
      delete gdatum_url(@gdatum)
    end

    assert_redirected_to gdata_url
  end
end
