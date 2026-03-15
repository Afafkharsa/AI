class MealPlan < ApplicationRecord
  belongs_to :user
  has_many :recipes, dependent: :destroy

  validates :meal, :date, :meal_type, presence: true
end
