require_relative '../api/mealdb'
class MealsController < ApplicationController
  before_action :authenticate_user!

  def add_meals_fromAPI

    @meal = current_user.meals.new(add_meals_fromapi)

    if @meal.save
      create_ingredients(params[:ingredients], @meal.id)
      redirect_to
    else

    end
  end

    def all_meals
        @all_meals = current_user.meals
    end

    def meal_byletter
      meal_db = Mealdb.new
      @list = meal_db.mealbyletter
    end

    def find_meal
      meal_byletter
      @meal_name = params[:search]
      if @meal_name.present?
        mealdb = Mealdb.new
        @meal_list = mealdb.search_mealbyName(@meal_name)
        render json: @meal_list
      else
        flash[:error] = "Search field cannot be empty"
      end
    end

    def search_results
      @meal_name = params[:search]
      if @meal_name.present?
        mealdb = Mealdb.new
        @meal_list = mealdb.search_mealbyName(@meal_name)
      else
        flash[:error] = "Search field cannot be empty"
      end
    end

    def add_meal
      all_meals
      @meal = Meal.new
    end

    def meals_category

    end

    def create
      @meal = current_user.meals.new(meal_params)
      if @meal.save
        redirect_to '/'
      else
        render :new
      end
    end

    def edit
      edit_meal
    end

    def destroy
      @meal = Meal.find(params[:id])
      @meal.ingredients.destroy_all
      @meal.order_items.destroy_all
      @meal.destroy
      redirect_to add_meal_path
    end

    def update
        @meal = Meal.find(params[:id])
        if @meal.update(update_meal_params)
          redirect_to add_meal_path, notice: 'Meal was successfully updated.'
        else
          render :edit
        end
    end



    private

    def create_ingredients(ingredients_params, meal_id)
      ingredients_params.each do |ingredient_params|
        next if ingredient_params[:ingredients_name].blank? || ingredient_params[:quantity].blank? || ingredient_params[:unit].blank?

        ingredient = Ingredient.create(
          meal_id: meal_id,
          ingredients_name: ingredient_params[:ingredients_name],
          quantity: ingredient_params[:quantity],
          unit: ingredient_params[:unit]
        )

        create_stocks(ingredient)
      end
    end

    def create_stocks(ingredient)
      # Find the corresponding stock, if it exists
      stock = Stock.find_by(ingredients_name: ingredient.ingredients_name, unit: ingredient.unit, user_id: current_user.id)

      if stock.present?
        # Update existing stock
        stock.update(quantity: stock.quantity + ingredient.quantity, unit: ingredient.unit)
      else
        # Create new stock
        Stock.create(
          user_id: current_user.id,
          ingredients_name: ingredient.ingredients_name,
          quantity: ingredient.quantity,
          unit: ingredient.unit
        )
      end
    end


    def edit_meal
      @meal = Meal.find(params[:id])
    end

    def add_meals_fromapi
      params.require(:meal).permit!
    end

    def update_meal_params
      params.require(:meal).permit(:meals_name, :meals_description, :meals_price)
    end

    def meal_params
      params.require(:meal).permit(:meals_name, :meals_description, :meals_price,  meals_directions: [], meals_nutritions: [] )
    end
end
