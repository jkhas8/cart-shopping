require "rails_helper"

RSpec.describe ItemsController, type: :controller do
  describe "Test actice create" do
    context "when current is a new record" do
      let (:product) { create :product }
      let (:item) do
        {
          quantity: 1,
          product_id: product.id
        }
      end

      it "should be render the create view for ajax" do
        post :create, params: { item: item, format: :js }
        expect(response).to render_template(:create)
        expect(current_cart.new_record?).to eq false
        expect(current_cart.items.size).to eq 1
        expect(current_cart.items.first.product).to eq product
        expect(current_cart.items.first.quantity).to eq 1
      end
    end

    context "when current cart is not a new record, and the item is not belong
    to this cart" do
      let (:product) { create :product }
      let (:cart) { create :cart }
      let (:item) do
        {
          quantity: 1,
          product_id: product.id
        }
      end

      before do
        update_cart cart
        old_product = create :product
        create :item, cart: cart, product: old_product
      end

      it "should be render the create view for ajax" do
        post :create, params: { item: item, format: :js }
        expect(response).to render_template(:create)
        expect(current_cart.items.size).to eq 2
        expect(current_cart.items.last.product).to eq product
        expect(current_cart.items.last.quantity).to eq 1
      end
    end
  end

  context "when current cart is not a new record, and the item is belong to
  this cart" do
    let (:product) { create :product }
    let (:cart) { create :cart }
    let (:item) do
      {
        quantity: 1,
        product_id: product.id
      }
    end

    before do
      update_cart cart
      create :item, cart: cart, product: product, quantity: 2
    end

    it "should be render the create view for ajax" do
      post :create, params: { item: item, format: :js }
      expect(response).to render_template(:create)
      expect(current_cart.items.last.product).to eq product
      expect(current_cart.items.last.quantity).to eq 3
    end
  end
end
