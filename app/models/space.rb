class Space < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :address, presence: true
  validates :price, presence: true
  has_many :bookings, dependent: :destroy
end
