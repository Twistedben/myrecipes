require 'test_helper'

class ChefsLoginTest < ActionDispatch::IntegrationTest
  
  test "invalid login is rejected" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: {email: " ", password: " " } }
    assert_template 'sessions/new'
    assert_not flash.empty? #After it fails, and FLash appears, we go to another route, which is below "get root_path".
    get root_path #Then, after we go to another route, it should get rid of the FLASH message.
    assert flash.empty? #Now we test to see if the flash is not there, because of the "flash.now" in our sessions_controller.rb
  end
  
  test "valid login credentials accepted and begin session" do
    get login_path
    assert_template 'sessions/new'
  end
  
end
