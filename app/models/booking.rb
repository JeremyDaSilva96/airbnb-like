class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :property

  # Validations
  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :number_of_guests, presence: true, numericality: { greater_than: 0 }
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true

  # Status enum
  enum status: {
    pending: 'pending',
    confirmed: 'confirmed',
    cancelled: 'cancelled',
    completed: 'completed'
  }, _default: 'pending'

  # Custom validations
  validate :check_out_after_check_in
  validate :guests_within_property_limit

  private

  def check_out_after_check_in
    return if check_in.blank? || check_out.blank?

    if check_out <= check_in
      errors.add(:check_out, "must be after the check-in date")
    end
  end

  def guests_within_property_limit
    return if number_of_guests.blank? || property.nil?

    if number_of_guests > property.max_guests
      errors.add(:number_of_guests, "cannot exceed the property's maximum capacity of #{property.max_guests}")
    end
  end
end
