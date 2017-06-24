class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: {minimum: 5, maximum: 500}
  belongs_to :chef #this is singular because it is the ONE side of the MANY side
  validates :chef_id, presence: true 
end 