class Recipe < ApplicationRecord
  belongs_to :meal_plan
  has_many :chats, dependent: :destroy

  validates :name, presence: true
  validates :ingredients, presence: true
  validates :method, presence: true
end
