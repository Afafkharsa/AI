# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Cleaning database..."
Recipe.destroy_all
MealPlan.destroy_all
User.destroy_all

puts "Creating users..."
user = User.create!(email: "famble@test.com", password: "123456")

puts "Creating meal plans..."
meal_plan_1 = MealPlan.create!(
  date: Date.today,
  meal_type: "lunch",
  meal: "Chickpea Salad",
  user: user
)

meal_plan_2 = MealPlan.create!(
  date: Date.today,
  meal_type: "dinner",
  meal: "Pasta with Tomato Sauce",
  user: user
)

meal_plan_3 = MealPlan.create!(
  date: Date.today + 1,
  meal_type: "lunch",
  meal: "Grilled Chicken Bowl",
  user: user
)

puts "Creating recipes..."
Recipe.create!(
  name: "Chickpea Salad",
  ingredients: "1 cup chickpeas, cucumber, olive oil, lemon",
  method: "Mix chickpeas with chopped cucumber. Add olive oil and lemon. Season with salt.",
  keywords: "vegan, healthy, quick",
  calories: 350,
  allergens: nil,
  meal_plan: meal_plan_1
)

Recipe.create!(
  name: "Pasta with Tomato Sauce",
  ingredients: "pasta, tomato sauce, garlic, olive oil",
  method: "Boil pasta. Cook garlic in olive oil, add tomato sauce. Mix with pasta.",
  keywords: "vegetarian, italian",
  calories: 550,
  allergens: "gluten",
  meal_plan: meal_plan_2
)

Recipe.create!(
  name: "Grilled Chicken Bowl",
  ingredients: "chicken breast, rice, avocado, lettuce",
  method: "Grill chicken. Serve with rice and sliced avocado on lettuce.",
  keywords: "high-protein, healthy",
  calories: 600,
  allergens: nil,
  meal_plan: meal_plan_3
)

puts "Finished! Created #{User.count} users, #{MealPlan.count} meal plans and #{Recipe.count} recipes"
