class Piece < ActiveRecord::Base
  belongs_to :user
  has_many :piece_patterns
  has_many :patterns, through: :piece_patterns
end
