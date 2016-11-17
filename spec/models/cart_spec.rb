require "rails_helper"

RSpec.describe Cart, type: :model do
  let (:cart) { build :cart }

  subject { cart }

  context "when status is one of list [open, done, cancel]" do
    Settings.model.cart.status.each do |status|
      before { subject.status = status }
      it { should be_valid }
    end
  end

  context "when status is not included in list [open, done, cancel]" do
    before { subject.status = "wrong_status" }
    it { is_expected.not_to be_valid }
  end
end
