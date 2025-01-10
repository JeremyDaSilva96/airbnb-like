class Property < ApplicationRecord
  has_many_attached :photos

  validates :title, presence: true
  validates :property_type, presence: true
  validates :price_per_night, presence: true, numericality: { greater_than: 0 }
  validates :max_guests, presence: true, numericality: { greater_than: 0 }
  validates :address, presence: true
  validates :city, presence: true
  validates :country, presence: true

  # Geocoding configuration
  geocoded_by :full_address
  after_validation :geocode, if: :address_changed?

  # Search configuration
  include PgSearch::Model
  pg_search_scope :search_by_location_and_attributes,
    against: [:title, :description, :address, :city, :country, :property_type],
    using: {
      tsearch: { prefix: true }
    }

  def full_address
    [address, city, country].compact.join(', ')
  end

  def address_changed?
    address_changed? || city_changed? || country_changed?
  end

  def travelers_favorite?
    travelers_favorite
  end
end
