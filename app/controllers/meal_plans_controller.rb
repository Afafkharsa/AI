class MealPlansController < ApplicationController

  def create
    if params[:plans].present?
    all_plans = params[:plans]
      all_plans.each do |_index, day_data|
      target_date = day_data[:date]
      day_data[:meals].each do |_m_index, meal_data|
        next if meal_data[:meal].blank?
        current_user.meal_plans.create!(date:target_date, meal:meal_data[:meal],
                                        meal_type:meal_data[:meal_type], calories:meal_data[:calories])
          end
        end
      redirect_to meal_plans_path, notice: "Meal plan saved successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    begin
    @date = params[:id].to_date
    rescue
    @date = Date.today
    end
    @meal_plans = current_user.meal_plans.all
    @weekly_plans = current_user.meal_plans.where(date: @date..(@date + 6.days)).order(:date, :meal, :meal_type)
  end


  private

  def meal_plans_params
    params.require(:meal_plan).permit(:date, :meal, :meal_type, :calories, :user_id)
  end
end
