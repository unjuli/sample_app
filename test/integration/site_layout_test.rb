require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get signup_path
    assert_select "title", full_title("Sign up")
    
    log_in_as(@user)
    assert_redirected_to @user
    get users_path
    assert_template 'users/index'
    assert_select "a[href=?]", login_path, count = 0
    get edit_user_path(@user)
    assert_template 'users/edit' 
  end
end

