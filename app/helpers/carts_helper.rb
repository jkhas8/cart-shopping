module CartsHelper
  def current_cart
    if session[:cart_id].present?
      Cart.find(session[:cart_id])
    else
      Cart.new
    end
  end

  def update_cart cart
    unless cart.is_cancel?
      session[:cart_id] = cart.id
    end
  end

  def cancel_cart
    session.delete(:cart_id)
  end
end
