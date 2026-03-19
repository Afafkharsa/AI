class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
  @recipes = Recipe.all
  end
  def create
  if params[:save_to_meal_plan]
    @meal_plan = current_user.meal_plans.find_or_create_by(
      date: params[:recipe][:meal_plan_date],
      meal_type: params[:recipe][:meal_plan_type]
    ) do |mp|
      mp.meal = params[:recipe][:name]
    end
    @recipe = @meal_plan.recipes.new(recipe_params)
  else
    @recipe = Recipe.new(recipe_params)
  end

  if @recipe.save
    if @meal_plan
      redirect_to meal_plan_path(@meal_plan), notice: "Recipe saved to meal plan!"
    else
      redirect_to recipes_path, notice: "Recipe saved!"
    end
  else
    redirect_back fallback_location: chats_path, alert: @recipe.errors.full_messages.join(", ")

  end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :ingredients, :method, :keywords, :calories, :allergens, :photo)
  end
end
