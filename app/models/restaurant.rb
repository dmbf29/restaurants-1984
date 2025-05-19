class Restaurant < ApplicationRecord
  # associations
  # dependent: :destroy ->
  has_many :reviews, dependent: :destroy # creates a method -> restaurant.reviews
  # validations
  validates :name, presence: true
  # validates :address, presence: true
end
