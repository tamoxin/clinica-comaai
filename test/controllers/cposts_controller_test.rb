require 'test_helper'

class CpostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cpost = cposts(:one)
  end

  test "should get index" do
    get cposts_url
    assert_response :success
  end

  test "should get new" do
    get new_cpost_url
    assert_response :success
  end

  test "should create cpost" do
    assert_difference('Cpost.count') do
      post cposts_url, params: { cpost: { body: @cpost.body, cfolder_id: @cpost.cfolder_id, link: @cpost.link, title: @cpost.title } }
    end

    assert_redirected_to cpost_url(Cpost.last)
  end

  test "should show cpost" do
    get cpost_url(@cpost)
    assert_response :success
  end

  test "should get edit" do
    get edit_cpost_url(@cpost)
    assert_response :success
  end

  test "should update cpost" do
    patch cpost_url(@cpost), params: { cpost: { body: @cpost.body, cfolder_id: @cpost.cfolder_id, link: @cpost.link, title: @cpost.title } }
    assert_redirected_to cpost_url(@cpost)
  end

  test "should destroy cpost" do
    assert_difference('Cpost.count', -1) do
      delete cpost_url(@cpost)
    end

    assert_redirected_to cposts_url
  end
end
