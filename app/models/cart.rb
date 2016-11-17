class Cart < ApplicationRecord
  has_many :items

  validates :status, presence: true,
    inclusion: { in: Settings.model.cart.status }

  accepts_nested_attributes_for :items,
    reject_if: ->(a){a[:quantity].blank?}, allow_destroy: true

  def is_cancel?
    self.status == "cancel"
  end
end
