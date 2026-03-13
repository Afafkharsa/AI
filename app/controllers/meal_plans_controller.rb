class MealPlansController < ApplicationController

  def index
    @today_meals = current_user.meal_plans.where(date: Date.today).order(:meal_type)
    @weekly_meals = current_user.meal_plans.where(date: Date.today..Date.today + 6.days).order(:meal_type)
  end

  def show
    @meal_plan = MealPlan.find(params[:id])
  end

  def create_daily

  end

  def create_weekly

  end

  private

  def meal_plan_params
    params.requir(:meal_plan).permit(:date, :meal,:meal_type, :photo, :user_id)
  end
end
