class MealPlan < ApplicationRecord
  belongs_to :user
  has_one :recipe, dependent: :destroy
  validates :meal, :date, :meal_type, presence: true
end
