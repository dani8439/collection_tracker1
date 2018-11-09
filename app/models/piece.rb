class Piece < ActiveRecord::Base
  belongs_to :user
  has_many :piece_patterns
  has_many :patterns, through: :piece_patterns

  validates_uniqueness_of :name, scope: [:size, :user_id]
end
