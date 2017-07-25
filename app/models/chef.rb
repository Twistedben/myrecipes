class Chef < ApplicationRecord
  before_save { self.email = email.downcase } #everytime before saving chef object, turns email to downcase
  validates :chefname, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255 },
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false } #tests uniqueness AND case insesnsitive
  has_many :recipes, dependent: :destroy  #The dependent means it will destroy recipes if Chef is destroyed
  has_secure_password #enables gem bcrypt
  validates :password, presence: true, length: {minimum: 5}, allow_nil: true
#Below, sets up one to many association with comments and if a chef is deletec, so is his comments.
  has_many :comments, dependent: :destroy 
end