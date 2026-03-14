class Recipe < ApplicationRecord
  belongs_to :meal_plan

  validates :name, presence: true
  validates :ingredients, presence: true
  validates :method, presence: true
end
