require "rails_helper"

RSpec.describe Item, type: :model do
  let (:product) { create :product }
  let (:cart) { create :cart }
  let (:item) { build :item, cart: cart, product: product}

  subject { item }

  context "when quantity <=0" do
    before { subject.quantity = 0 }
    it { is_expected.not_to be_valid }
  end

  context "when quantity is nil" do
    before { subject.quantity = nil }
    it { is_expected.not_to be_valid }
  end

  context "when quantity is not a number" do
    before { subject.quantity = "12a" }
    it { is_expected.not_to be_valid }
  end

  context "when quantity is not an integer" do
    before { subject.quantity = 1.2 }
    it { is_expected.not_to be_valid }
  end
end
