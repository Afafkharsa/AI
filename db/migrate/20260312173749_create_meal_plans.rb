class CreateMealPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :meal_plans do |t|
      t.date :date
      t.string :meal_type

      t.timestamps
    end
  end
end
