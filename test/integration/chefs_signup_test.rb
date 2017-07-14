require 'test_helper'

class ChefsSignupTest < ActionDispatch::IntegrationTest
  
#BElow, we test for a route to signup for new users, like ".../signup"
  test "should get signup path" do
    get signup_path
    assert_response :success
  end
  
  test "reject an invalid signup" do
    get signup_path
#Below, we should post to Chef count, there should be no change in Chef #'s.
    assert_no_difference "Chef.count" do
      post chefs_path, params: { chef: {chefname: "", email: "", password: "password",
                                        password_confirmation: "password"  } }
    end
#Below, at this point, we should post the new template again with errors having shown up, errors in our partial
    assert_template 'chefs/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end 
  
  test "accept valid signup" do
    get signup_path
#Below, we assert there IS a differnece of "1"
    assert_difference "Chef.count", 1 do
      post chefs_path, params: { chef: {chefname: "Benjamin", email: "bensgamingmail@yahoo.com", password: "password",
                                        password_confirmation: "password" }}
    end
#Since this should be successful, we will not see the 'new' template but a redirect to a profile page (show), 
#followed by a Flash message that displays success
    follow_redirect!
    assert_template 'chefs/show'
    assert_not flash.empty? 
  end 
  
end
