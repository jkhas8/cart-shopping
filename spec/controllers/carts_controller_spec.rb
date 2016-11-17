require "rails_helper"

RSpec.describe CartsController, type: :controller do
  let (:cart) { create :cart }

  describe "Test action show" do
    context "when the cart does not have any items" do
      before do
        update_cart cart
        cart.items.destroy_all
      end

      it "should redirect to the product index page" do
        get :show, params: { id: cart.id }
        expect(response).to redirect_to products_path
      end
    end

    context "when the cart is not created" do
      before do
        cancel_cart
      end

      it "should redirect to the product index page" do
        get :show, params: { id: cart.id }
        expect(response).to redirect_to products_path
      end
    end

    context "when the cart has some items" do
      before do
        update_cart cart
        product = create :product
        create :item, product: product, cart: cart
      end

      it "should render the show page" do
        get :show, params: { id: cart.id }
        expect(response).to render_template :show
        expect(assigns(:items).length).to eq 1
      end
    end
  end

  describe "Test action update" do
    context "when call a POST request with the params which will change the
      quantity of an item and delete another one" do
      let (:product_1) { create :product }
      let (:product_2) { create :product }
      let (:item_1) { create :item, product: product_1, cart: cart }
      let (:item_2) { create :item, product: product_2, cart: cart }
      let (:param) do
        {
          items_attributes: {
            "0": {
              quantity: 2,
              product_id: product_1.id,
              id: item_1.id
            },
            "1": {
              quantity: 1,
              product_id: product_2.id,
              id: item_2.id,
              _destroy: 1
            }
          }
        }
      end

      before do
        update_cart cart
      end

      it "should redirect to carts page" do
        put :update, params: { id: cart.id, cart: param }
        expect(response).to redirect_to(cart_path cart)

        cart.reload
        expect(cart.items.size).to eq 1

        item_1.reload
        expect(item_1.quantity).to eq 2
      end
    end
  end

  describe "Test action destroy" do
    context "when the cart is not created" do
      before do
        cancel_cart
      end

      it "should redirect to products page" do
        delete :destroy, params: { id: cart.id }
        expect(response).to redirect_to(products_path)
        expect(current_cart.new_record?).to eq true
      end
    end

    context "when the cart is exist" do
      before do
        update_cart cart
      end
      it "should redirect to products page" do
        delete :destroy, params: { id: cart.id }
        expect(response).to redirect_to(products_path)
        cart.reload
        expect(cart.status).to eq "cancel"
      end
    end
  end
end
