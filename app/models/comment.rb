class Comment < ApplicationRecord
  validates :description, presence: true, length: {minimum: 4, maximum: 140 }
  validates :chef_id, presence: true
  validates :recipe_id, presence: true
#Below, we set up the association to the chef and recipe model.
  belongs_to :chef
  belongs_to :recipe
 #Below, the latest posted comment will the on top, the first to show
  default_scope -> { order(updated_at: :desc)}
end