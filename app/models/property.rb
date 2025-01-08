class Property < ApplicationRecord
  has_many_attached :photos

  validates :title, presence: true
  validates :property_type, presence: true
  validates :price_per_night, presence: true, numericality: { greater_than: 0 }
  validates :max_guests, presence: true, numericality: { greater_than: 0 }
  validates :address, presence: true
  validates :city, presence: true
  validates :country, presence: true
end
