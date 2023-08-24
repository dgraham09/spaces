class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :space, counter_cache: true

  validates :booking_start_date, presence: true, availability: true
  validates :booking_end_date, presence: true, availability: true

  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
