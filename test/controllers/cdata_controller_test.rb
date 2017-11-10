require 'test_helper'

class CdataControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cdatum = cdata(:one)
  end

  test "should get index" do
    get cdata_url
    assert_response :success
  end

  test "should get new" do
    get new_cdatum_url
    assert_response :success
  end

  test "should create cdatum" do
    assert_difference('Cdatum.count') do
      post cdata_url, params: { cdatum: { body: @cdatum.body, cfolder_id: @cdatum.cfolder_id, link: @cdatum.link, title: @cdatum.title } }
    end

    assert_redirected_to cdatum_url(Cdatum.last)
  end

  test "should show cdatum" do
    get cdatum_url(@cdatum)
    assert_response :success
  end

  test "should get edit" do
    get edit_cdatum_url(@cdatum)
    assert_response :success
  end

  test "should update cdatum" do
    patch cdatum_url(@cdatum), params: { cdatum: { body: @cdatum.body, cfolder_id: @cdatum.cfolder_id, link: @cdatum.link, title: @cdatum.title } }
    assert_redirected_to cdatum_url(@cdatum)
  end

  test "should destroy cdatum" do
    assert_difference('Cdatum.count', -1) do
      delete cdatum_url(@cdatum)
    end

    assert_redirected_to cdata_url
  end
end
