class MealPlansController < ApplicationController
  def index
    @meal_plans = current_user.meal_plans
    #@meal_plan = MealPlan.new
    @today_meals = current_user.meal_plans.where(date: Date.today).order(:meal_type)
    @weekly_meals = current_user.meal_plans.where(date: Date.today..Date.today + 6.days).order(:meal_type)
  end

  def show
    @meal_plan = MealPlan.find(params[:id]) #current_user.meal_plans
    @recipe = @meal_plan.recipe
  end

  def new
    @meal_plan = MealPlan.new
  end

  def create
    @meal_plan = current_user.meal_plans.new(meal_plan_params)
    if @meal_plan.save
      redirect_to meal_plan_path(@meal_plan)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def meal_plan_params
    params.require(:meal_plan).permit(:date, :meal, :meal_type, :photo, :user_id)
  end
end
