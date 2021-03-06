require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "ben", email: "Bensgamingmail@yahoo.com",
                     password: "password", password_confirmation: "password")
  end 
  
  test "should be valid" do
    assert @chef.valid?
  end
  
  test "name should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end
  
  test "name should be less than 30 characters" do
    @chef.chefname = "a" * 31
    assert_not @chef.valid?
  end
  
  test "email should be preset" do 
    @chef.email = " "
    assert_not @chef.valid?
  end
  
  test "email should not be too long" do
    @chef.email = "a" * 245 + "@example.com"
    assert_not @chef.valid?
  end
  #we have to build an array of correctly formatted email addresses. %w creates the array
  test "email should accept correct format" do
    valid_emails = %w[user@example.com BEN@gmail.com B.first@yahoo.ca john+smith@co.uk.org]
    valid_emails.each do |valids|
      @chef.email = valids
      assert @chef.valid?, "#{valids.inspect} should be valid"
    end 
  end
  
  test "should reject invalid addresses" do
    invalid_emails = %w[benjamin@example ben@example,com ben.name@gmail. joe@bar+foo.com]
    invalid_emails.each do |invalids|
      @chef.email = invalids
      assert_not @chef.valid?, "#{invalids.inspect} should be invalid"
    end
  end 
  
  test "email should be unique and case insensitive" do
    duplicate_chef = @chef.dup   #creating the duplicate of the @chef instance variable
    duplicate_chef.email = @chef.email.upcase #assigning email to chef's email
    @chef.save  
    assert_not duplicate_chef.valid?
  end
  
  test "email should be lowercase before saving DB" do
    mixed_email = "JohN@Example.com"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email #takes first argument and compares with second
  end
  
  test "password should be present" do
#If the chef's password and confirmation is empty, then it should be invalid
    @chef.password = @chef.password_confirmation = " "
    assert_not @chef.valid?
  end
  
  test "password should be at least 5 characters" do
    @chef.password = @chef.password_confirmation = "x" * 4
    assert_not @chef.valid?
  end 
  
  test "associated recipes should be destroyed" do
#Because our Setup method doesn't save the @chef, we first have to do that below
    @chef.save
#Now, we need to create a recipe as well so we can test the association's destroy action
    @chef.recipes.create!(name: "testing destroy", description: "testing destroy function")
#To ensure the recipe was also deleted, we have to ensure there's a difference in the recipes
    assert_difference 'Recipe.count', -1 do 
      @chef.destroy #If we destroy the chef, the recipe count should go down by 1
    end
  end
  
end