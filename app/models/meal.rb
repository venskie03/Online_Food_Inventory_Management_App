class Meal < ApplicationRecord
  belongs_to :user
  has_many :ingredients

  has_many :order_items
  has_many :orders, through: :order_items
  validates :meals_name, presence: true
  validates :meals_description, presence: true
  validates :meals_price, presence: true
  validates :user_id, presence: true
end
