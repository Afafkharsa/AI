class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :ingredients
      t.text :method
      t.text :keywords
      t.integer :calories
      t.text :allergens
      # t.references :meal_plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
