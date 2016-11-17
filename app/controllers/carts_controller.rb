class CartsController < ApplicationController
  before_action :get_cart

  def show
    @items = @cart.items
    redirect_to products_path if @items.size == 0
  end

  def update
    @cart.update_attributes(cart_params)
    redirect_to cart_path @cart
  end

  def destroy
    @cart.update(status: "cancel") unless @cart.new_record?
    # can use destroy method
    cancel_cart
    redirect_to products_path
  end

  private
  def cart_params
    params.require(:cart).permit(items_attributes: [:quantity, :product_id, :id,
      :_destroy])
  end

  def get_cart
    @cart = current_cart
  end
end
