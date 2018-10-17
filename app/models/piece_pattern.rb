class PiecePattern < ActiveRecord::Base
  belongs_to :piece
  belongs_to :pattern
end
