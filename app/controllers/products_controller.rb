class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(Settings.constant.per_page)
    @item = current_cart.items.new
  end
end
