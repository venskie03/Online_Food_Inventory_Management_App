class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
      @orders = current_user.orders.order(created_at: :desc)
      render 'history'
  end

  def menu
      @order = Order.new
      @meals = current_user.meals.all
      @order_item = @order.order_items.build
  end

  def create
      @order = Order.new(order_params)
      @meals = Meal.all
      total_bill = calculate_total_bill(params[:order][:order_items_attributes])
      @order.total_bill = total_bill

      @order.order_items = @order.order_items.to_a.reject { |item| item.quantity.zero? }

      respond_to do |format|
        if @order.save
          format.html { redirect_to orders_new_path, notice: 'Order was successfully created.' }
          format.json { render :show, status: :created, location: @order }
        else
          format.html { render :menu, status: :unprocessable_entity }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
  end

  private

  def order_params
      params.require(:order).permit(:total_bill, :user_id, order_items_attributes: [:meal_id, :order_id, :quantity])
  end

  def calculate_total_bill(order_items_attributes)
    total_bill = 0
    order_items_attributes.each do |index, order_item_params|
      meal = Meal.find(order_item_params[:meal_id])
      quantity = order_item_params[:quantity].to_i
      total_bill += meal.meals_price * quantity
    end
    total_bill
  end

end
