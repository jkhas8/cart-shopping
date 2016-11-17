require "rails_helper"

RSpec.describe Product, type: :model do
  let (:product) { build :product }

  subject { product }

  context "when name is blank" do
    before { subject.name = " " }
    it { is_expected.not_to be_valid }
  end

  context "when name is empty" do
    before { subject.name = "" }
    it { is_expected.not_to be_valid }
  end

  context "when name is nil" do
    before { subject.name = nil }
    it { is_expected.not_to be_valid }
  end

  context "when length of name is more than 50" do
    before { subject.name = "a" * 51 }
    it { is_expected.not_to be_valid }
  end

  context "when status is one of list [active, deleted]" do
    Settings.model.product.status.each do |status|
      before { subject.status = status }
      it { should be_valid }
    end
  end

  context "when status is not included in list [active, deleted]" do
    before { subject.status = "wrong_status" }
    it { is_expected.not_to be_valid }
  end

  context "when cost <0" do
    before { subject.cost = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when cost is not integer" do
    before { subject.cost = 0.1 }
    it { is_expected.not_to be_valid }
  end

  context "when cost is nil" do
    before { subject.cost = nil }
    it { is_expected.not_to be_valid }
  end

  context "when description is blank" do
    before { subject.description = " " }
    it { is_expected.not_to be_valid }
  end

  context "when description is empty" do
    before { subject.description = "" }
    it { is_expected.not_to be_valid }
  end

  context "when description is nil" do
    before { subject.description = nil }
    it { is_expected.not_to be_valid }
  end

  context "when length of description is more than 100" do
    before { subject.description  = "a" * 101 }
    it { is_expected.not_to be_valid }
  end
end
