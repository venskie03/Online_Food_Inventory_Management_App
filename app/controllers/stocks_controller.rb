class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock, only: %i[ edit update ]

  def index
      @stocks = current_user.stocks.order(:ingredients_name)
  end

  def edit
  end

  def update
      respond_to do |format|
          if @stock.update(stock_params)
              format.html { redirect_to stocks_path, notice: "Quantity was successfully updated." }
              format.json { render :show, status: :ok, location: @category }
          else
              format.html { render :edit, status: :unprocessable_entity }
              format.json { render json: @stock.errors, status: :unprocessable_entity }
          end
      end
  end

  private

  def set_stock
      @stock = Stock.find(params[:id])
  end

  def stock_params
      params.require(:stock).permit(:quantity)
  end
end
