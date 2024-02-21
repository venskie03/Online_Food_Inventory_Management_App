class IngredientsController < ApplicationController
  def meal_ingredients
    @list_ingredients = Ingredient.where(meal_id: params[:meal_id])
    @meals_info = Meal.where(id: params[:meal_id])
  end

  def add
    meal_ingredients
    @ingredients = Ingredient.new
  end

  def create
   # Find the meal based on the meal_id parameter
  @meal = Meal.find(params[:meal_id])

  # Find or initialize the ingredient by its name
  @ingredient = Ingredient.find_or_initialize_by(ingredients_name: ingredients_params[:ingredients_name]) do |ingredient|
    # Update the ingredient's attributes
    ingredient.meal_id = @meal.id
    ingredient.quantity = ingredients_params[:quantity]
    ingredient.unit = ingredients_params[:unit]
  end

  if @ingredient.persisted?
    # If the ingredient already exists, update its attributes
    @ingredient.update(quantity: ingredients_params[:quantity], unit: ingredients_params[:unit])
  else
    # If the ingredient is new, save it
    @ingredient.save
  end

  # Handle stock accordingly (updating or creating)
  update_or_create_stock

  redirect_to add_meal_path
  end

  private

  def update_or_create_stock
    # Find the corresponding stock, if it exists
    stock = Stock.find_by(ingredients_name: @ingredient.ingredients_name, user_id: current_user.id)

    if stock.present?
      # Update existing stock
      stock.update(quantity: stock.quantity + @ingredient.quantity, unit: @ingredient.unit)
    else
      # Create new stock
      Stock.create(
        user_id: current_user.id,
        ingredients_name: @ingredient.ingredients_name,
        quantity: @ingredient.quantity,
        unit: @ingredient.unit
      )
    end
  end

  def ingredients_params
    params.permit(:ingredients_name, :quantity, :unit, :meal_id)
  end
end
