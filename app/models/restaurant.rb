class Restaurant < ApplicationRecord
  # associations
  belongs_to :user
  # dependent: :destroy ->
  has_many :reviews, dependent: :destroy # creates a method -> restaurant.reviews
  # validations
  validates :name, presence: true
  # validates :address, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
