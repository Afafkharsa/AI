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
Chat.destroy_all
Message.destroy_all

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

recipe = Recipe.create!(
  name: "Chickpea Salad",
  ingredients: "chickpeas - 1 cup\ncucumber - 1\nolive oil - 2 tbsp\nlemon - 1",
  method: "Mix chickpeas with chopped cucumber.\nAdd olive oil and lemon.\nSeason with salt.",
  keywords: "vegan, healthy, quick",
  calories: 350,
  allergens: nil,
  meal_plan: meal_plan_1
)

recipe = Recipe.create!(
  name: "Pasta with Tomato Sauce",
  ingredients: "pasta - 100 g\ntomato sauce - 150 g\ngarlic - 1 clove\nolive oil - 1 tbsp",
  method: "Boil pasta in salted water until al dente.\nCook garlic in olive oil until fragrant.\nAdd tomato sauce and simmer for 5 minutes.\nMix sauce with cooked pasta.",
  keywords: "vegetarian, italian",
  calories: 550,
  allergens: "gluten",
  meal_plan: meal_plan_2
)

recipe = Recipe.create!(
  name: "Grilled Chicken Bowl",
  ingredients: "chicken breast - 150 g\nrice - 100 g\navocado - 1/2\nlettuce - 1 cup",
  method: "Boil pasta in salted water until al dente.\nCook garlic in olive oil until fragrant.\nAdd tomato sauce and simmer for 5 minutes.\nMix sauce with cooked pasta.",
  keywords: "high-protein, healthy",
  calories: 600,
  allergens: nil,
  meal_plan: meal_plan_3
)

puts "Finished! Created #{User.count} users, #{MealPlan.count} meal plans and #{Recipe.count} recipes"


puts "Generating AI photo..."

ImageGeneratorService.generate_and_attach(recipe)
sleep 5

puts "Generated photo successful!"


puts "Creating chats..."

chat_1 = Chat.create!(
  user: user,
  title: "High protein recipe",
)

chat_2 = Chat.create!(
  user: user,
  title: "Funny Breakfast",
)

puts "Creating chat's messages..."

Message.create!(
  chat: chat_1,
  role: "user",
  content: "Help me find a high-protein recipe"
)

Message.create!(
  chat: chat_1,
  role: "assistant",
  content: '
    {
      "name": "High-Protein Greek Yogurt Chicken Salad",
      "ingredients": [
        {"ingredient": "cooked chicken breast, shredded", "quantity": "150 g"},
        {"ingredient": "plain nonfat Greek yogurt", "quantity": "120 g"},
        {"ingredient": "celery, finely chopped", "quantity": "50 g"},
        {"ingredient": "red onion, finely chopped", "quantity": "20 g"},
        {"ingredient": "lemon juice", "quantity": "1 tablespoon"},
        {"ingredient": "Dijon mustard", "quantity": "1 teaspoon"},
        {"ingredient": "salt", "quantity": "1/4 teaspoon"},
        {"ingredient": "black pepper", "quantity": "1/4 teaspoon"},
        {"ingredient": "fresh parsley, chopped", "quantity": "1 tablespoon"}
      ],
      "method": [
        "Place the shredded cooked chicken breast in a large bowl.",
        "Add the Greek yogurt, lemon juice, and Dijon mustard.",
        "Mix in the chopped celery, red onion, and parsley.",
        "Season with salt and black pepper.",
        "Stir everything together until well combined and creamy.",
        "Serve immediately or refrigerate for 30 minutes to enhance the flavor."
      ],
      "keywords": ["high protein", "healthy", "low carb", "quick meal"],
      "calories": 310,
      "allergens": ["dairy", "mustard"]
    }
  '
)

Message.create!(
  chat: chat_2,
  role: "user",
  content: "help me find a funny breakfast "
)

Message.create!(
  chat: chat_1,
  role: "assistant",
  content: '
    {
      "name": "Pancake Smiley Faces",
      "ingredients": [
        {"ingredient": "pancake mix, shredded", "quantity": "200 g"},
        {"ingredient": "water or milk", "quantity": "150 ml"},
        {"ingredient": "chocolate chips", "quantity": "50 g"},
        {"ingredient": "banana slices", "quantity": "1 banana"},
        {"ingredient": "strawberries ", "quantity": "3 pieces"}
      ],
      "method": [
        "Prepare the pancake batter according to the instructions on the mix using water or milk.",
        "Heat a non-stick pan on medium heat and pour small amounts of batter to create pancakes.",
        "Cook each pancake for 2-3 minutes per side until golden brown.",
        "Use chocolate chips to create the eyes and mouth on each pancake.",
        "Add banana slices and strawberries as additional decorations for the funny face.",
        "Serve and enjoy your funny pancake breakfast."
      ],
      "keywords": ["fun breakfast", "pancakes", "decorative"],
      "calories": 400,
      "allergens": ["gluten", "dairy"]
    }
  '
)

puts "Finished! Created #{Chat.count} chat(s) and #{Message.count} messages"
