require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Ben", email: "Bensgamingmail@yahoo.com",
                         password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "fred", email: "Fred@example.com",
                         password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chefname: "bill", email: "bill@example.com",
                  password: "password", password_confirmation: "password", admin: true)
  end 
  
  test "reject an invalid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
#Below, we use patch since we're using the Update action
    patch chef_path(@chef), params: { chef: {chefname: "", email: "Bensgamingmail@yahoo.com"} }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end 
  
  test "accept valid edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: {chefname: "Ben1", email: "bensgamingmail1@yahoo.com" } }
    assert_redirected_to @chef #@chef is short form for the Show page
    assert_not flash.empty?
    @chef.reload
    assert_match "Ben1", @chef.chefname
    assert_match "bensgamingmail1@yahoo.com", @chef.email
  end 
  
  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user, "password")
    get edit_chef_path(@chef)#Getting the edit of the first chef, not the editing of the admin
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: {chefname: "Ben3", email: "bensgamingmail3@yahoo.com" } }
    assert_redirected_to @chef 
    assert_not flash.empty?
    @chef.reload
    assert_match "Ben3", @chef.chefname#Making sure the update occured
    assert_match "bensgamingmail3@yahoo.com", @chef.email
  end
  
  test "redirect edit attempt by another non-admin user" do
    sign_in_as(@chef2, "password")
    updated_name = "joe" #This is what chef2 is attempting to patch in as an edit
    updated_email = "Joe@example.com"
    patch chef_path(@chef), params: { chef: {chefname: updated_name, email: updated_email } }
    assert_redirected_to chefs_path #According to our controller this is where the chef is redirected
    assert_not flash.empty?
    @chef.reload
    assert_match "Ben", @chef.chefname#Making sure the update DID NOT occur, as the values are the same and unchange
    assert_match "bensgamingmail@yahoo.com", @chef.email
  end 
  
end
