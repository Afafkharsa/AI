class RecipesController < ApplicationController
  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to meal_plan_path(@recipe.meal_plan)
    else
      render :new, status: :unprocessable_entity
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
