class AddRecipeToMealPlans < ActiveRecord::Migration[7.1]
  def change
    add_reference :meal_plans, :recipe, foreign_key: true
  end
end
