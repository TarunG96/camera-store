class Product < ApplicationRecord
  belongs_to :category
  validates :make, numericality: { only_integer: true , message: "%{value} is not a valid make" }
end
