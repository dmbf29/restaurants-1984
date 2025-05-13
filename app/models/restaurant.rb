class Restaurant < ApplicationRecord
  # associations
  # validations
  validates :name, presence: true
  validates :address, presence: true
end
