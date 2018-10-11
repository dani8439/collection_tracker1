class Piece < ActiveRecord::Base
  has_many :collections 
  has_many :patterns, through: :collections
end
