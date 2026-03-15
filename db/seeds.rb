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

puts "Creating chat..."

chat_1 = Chat.create!(
  user_id: user,
  title: "High protein recipe",
)

puts "Creating chat message"

Message.create!(
  chat_id: chat_1,
  role: "user",
  content: "You are a recipe assistant, helping users find and create recipes.
  I am a user looking to discover new recipes, get cooking instructions and track
  my calories. Help me find, suggest and create recipes. Always structure your
  recipe with: - Name - Ingredients with quantities - Step by step method -
  Total calories - Allergens suggest me a high protecin recipe Answer in json."
)

Message.create!(
  chat_id: chat_1,
  role: "assistant",
  content: '
    {
      "name": "High-Protein Turkey & Egg White Scramble",
      "ingredients": [
        {"ingredient": "lean ground turkey", "quantity": "150 g"},
        {"ingredient": "egg whites", "quantity": "120 g (about 4 egg whites)"},
        {"ingredient": "olive oil", "quantity": "1 teaspoon"},
        {"ingredient": "spinach", "quantity": "1 cup (30 g)"},
        {"ingredient": "red bell pepper, diced", "quantity": "1/2 cup (75 g)"},
        {"ingredient": "garlic, minced", "quantity": "1 clove"},
        {"ingredient": "salt", "quantity": "1/4 teaspoon"},
        {"ingredient": "black pepper", "quantity": "1/4 teaspoon"}
      ],
      "method": [
        "Heat olive oil in a non-stick pan over medium heat.",
        "Add minced garlic and cook for about 30 seconds until fragrant.",
        "Add ground turkey and cook for 5–6 minutes, breaking it apart until fully browned.",
        "Add diced bell pepper and cook for 2 minutes.",
        "Stir in spinach and cook until wilted.",
        "Pour in egg whites and gently scramble everything together.",
        "Cook for 2–3 minutes until egg whites are fully set. Season with salt and black pepper.",
        "Serve warm."
      ],
      "total_calories": 330,
      "allergens": ["Eggs"]
    }
  '
)


puts "Finished! Created #{Chat.count} chats and #{Message.count} messages"
