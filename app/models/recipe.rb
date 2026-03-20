class Recipe < ApplicationRecord
  belongs_to :meal_plan, optional: true
  # has_many :chats, dependent: :destroy
  has_one_attached :photo

  validates :name, presence: true
  validates :ingredients, presence: true
  validates :method, presence: true
end
