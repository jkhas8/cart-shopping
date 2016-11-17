class ItemsController < ApplicationController
  def create
    @cart = current_cart
    @cart.save if @cart.new_record?
    @item = @cart.items.find_by product_id: params[:item][:product_id]
    if @item.present?
      @item.quantity += params[:item][:quantity].to_i
      @item.save
    else
      @item = @cart.items.new(item_params)
      @cart.save
    end
    update_cart @cart
  end

  private
  def item_params
    params.require(:item).permit(:quantity, :product_id)
  end
end
