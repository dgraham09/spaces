class Space < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo

  validates :name, presence: true
  validates :address, presence: true
  validates :price, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :search_by_address,
    against: [ :name, :address ],
    using: {
      tsearch: { prefix: true }
  }
  # pg_search_scope :search_by_dates,
  #   against: [ :date ],
  #   using: {
  #     tsearch: { prefix: true }
  # }
end
