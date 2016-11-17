class Cart < ApplicationRecord
  has_many :items

  validates :status, presence: true, inclusion: { in: Settings.model.cart.status }
end
