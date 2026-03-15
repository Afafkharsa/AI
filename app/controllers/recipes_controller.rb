class RecipesController < ApplicationController
  def create
    meal_plan = current_user.meal_plans.first

    @recipe = Recipe.new(recipe_params)
    @recipe.meal_plan = meal_plan

    if @recipe.save
      redirect_to meal_plan_recipe_path(@recipe.meal_plan, @recipe)
    else
      render :new, status: :unprocessable_entry
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :ingredients, :method, :keywords, :calories, :allergens, :meal_plan_id)
  end
end
