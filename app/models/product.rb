class Product < ApplicationRecord
  has_many :items

  validates :status, presence: true,
    inclusion: { in: Settings.model.product.status }
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 100 }
  validates :cost, presence: true, numericality: { only_integer: true,
    greater_than_or_equal_to: 0 }
end
