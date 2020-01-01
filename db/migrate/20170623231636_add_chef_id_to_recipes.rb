class AddChefIdToRecipes < ActiveRecord::Migration[5.1]
  def change #adding column to what table? :recipes Name of column? :chef_id Data type? :integer (all keys are)
    add_column :recipes, :chef_id, :integer 
  end
end
