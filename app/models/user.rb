class User < ActiveRecord::Base
  has_many :pieces
  has_many :patterns, through: :pieces
  has_many :wishlists

  has_secure_password
  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true
end
