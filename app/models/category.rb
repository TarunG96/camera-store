class Category < ApplicationRecord
  has_many :products
  validates :name, presence: true
  validates :category_type, inclusion: { in: ["Mirrorless","full frame","point and shoot"],
    message: "%{value} is not a valid category type" }
  validates :model, numericality: { only_integer: true }, presence: true

end
