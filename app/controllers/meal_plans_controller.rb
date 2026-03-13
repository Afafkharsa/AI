class MealPlansController < ApplicationController

  def index
    @today_meals = current_user.meal_plans.where(date: Date.today).order(:meal_type)
    @weekly_meals = current_user.meal_plans.where(date: Date.today..Date.today + 6.days).order(:meal_type)
  end

  def show
    @meal_plan = MealPlan.find(params[:id])
  end

  def create
    @meal_plan = current_user.meal_plan.new(meal_plan_params)
    if @meal_plan.save
      redirect_to meal_plan_path(@meal_plan)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def meal_plan_params
    params.requir(:meal_plan).permit(:date, :meal_type, :photo, :user_id)
  end
end
