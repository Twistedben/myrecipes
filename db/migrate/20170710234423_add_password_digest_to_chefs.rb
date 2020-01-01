class AddPasswordDigestToChefs < ActiveRecord::Migration[5.1]
  def change
#Below, adds a new column to the table "chefs", named "password_digest", as a "string". Required for BCrypt
    add_column :chefs, :password_digest, :string
  end
end
