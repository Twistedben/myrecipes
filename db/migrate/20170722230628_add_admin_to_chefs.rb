class AddAdminToChefs < ActiveRecord::Migration[5.1]
  def change
#Below, in the "chefs" table, we add a column named "admin" with the type of "boolean" and a defualt value of "false"
    add_column :chefs, :admin, :boolean, default: false
  end
end
