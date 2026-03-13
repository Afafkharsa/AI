class MealPlan < ApplicationRecord
  belongs_to :user
  has_many :recipes, dependent: :destroy
  has_one_attached :photo
  validates :meal, presence: true
end
