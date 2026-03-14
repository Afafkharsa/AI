class User < ApplicationRecord
  has_many :meal_plans, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :meal_plans
  has_many :recipes, through: :meal_plans
  has_many :chats, dependent: :destroy
end
