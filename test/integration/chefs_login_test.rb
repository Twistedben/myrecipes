require 'test_helper'

class ChefsLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Ben", email: "bensgamingmail@yahoo.com", password: "password")
  end
  
  test "invalid login is rejected" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: {email: " ", password: " " } }
    assert_template 'sessions/new'
    assert_not flash.empty? #After it fails, and FLash appears, we go to another route, which is below "get root_path".
#Below, the two assert_selects check whether the login path is visible, meaning no login, and making sure the logout
#link in the navbar is not visible, meaning no logged in user
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    get root_path #Then, after we go to another route, it should get rid of the FLASH message.
    assert flash.empty? #Now we test to see if the flash is not there, because of the "flash.now" in our sessions_controller.rb
  end
#Because the test below requires a real user to login successfully, it is dependent on the abovew "def setup" to run a valid
#test.
  test "valid login credentials accepted and begin session" do
    get login_path
    assert_template 'sessions/new'
#Below, if successfully logged in by using the user we setup in the "def setup", then we want to go to the show page.
    post login_path, params: { session: { email: @chef.email, password: @chef.password } }
    assert_redirected_to @chef #Redirected to chef_path after having logged in properly.
    follow_redirect!
    assert_template 'chefs/show' #Ensure the above two lines directed us to the chef's show page.
    assert_not flash.empty? #Make sure flash is not empty and got "Successfully logged in" from Create action flash.
#The links below are testing the visibility based on whether the user is logged in or not. The only link that should
#not show is the "login" link, hence the "count: 0"
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", chef_path(@chef)
    assert_select "a[href=?]", edit_chef_path(@chef)
  end
  
end
