class PiecePattern < ActiveRecord::Base
  belongs_to :piece
  belongs_to :pattern

  has_many :users, through: :pieces
  has_many :users
end
