class Ingredient < ApplicationRecord
  validates :name, presence: true, length: {minimum: 3, maximum: 25}
#Below, this ensures that an ingredient is unique and isn't created many times, but only once.
  validates_uniqueness_of :name 
end 