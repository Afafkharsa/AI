class MakeMealPlanRequiredInRecipes < ActiveRecord::Migration[7.1]
  def change
    change_column_null :recipes, :meal_plan_id, false
  end
end
