class Order < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items
  accepts_nested_attributes_for :order_items

  belongs_to :user

  validate :at_least_one_meal_ordered, on: :create
  validate :enough_ingredients_in_stock, on: :create
  after_create :update_stock_quantities

  private

  def at_least_one_meal_ordered
      if order_items.none? { |item| item.quantity.positive? }
        errors.add(:base, 'At least one meal must be ordered')
      end
  end

  def enough_ingredients_in_stock
    insufficient_stock_ingredients = []

    order_items.each do |order_item|
      meal = order_item.meal
      required_ingredients = meal.ingredients

      required_ingredients.each do |ingredient|
        stock = Stock.find_by(ingredients_name: ingredient.ingredients_name)
        if stock.nil? || stock.quantity < ingredient.quantity * order_item.quantity
          insufficient_stock_ingredients << ingredient.ingredients_name
        end
      end
    end

    unless insufficient_stock_ingredients.empty?
      errors.add(:base, "Insufficient stock for #{insufficient_stock_ingredients.join(', ')}")
      return false
    end

    true
  end

  def update_stock_quantities
    order_items.each do |order_item|
      meal = order_item.meal
      required_ingredients = meal.ingredients

      required_ingredients.each do |ingredient|
        stock = Stock.find_by(ingredients_name: ingredient.ingredients_name)
        stock.update(quantity: stock.quantity - (ingredient.quantity * order_item.quantity))
      end
    end
  end
end
