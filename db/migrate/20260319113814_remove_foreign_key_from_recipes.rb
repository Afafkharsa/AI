class RemoveForeignKeyFromRecipes < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key "recipes", "meal_plans"
  end
end
