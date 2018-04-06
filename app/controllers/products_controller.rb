class ProductsController < ApplicationController
  def show
    render json: Product.find(params[:id])
  end
end
