class Pattern < ActiveRecord::Base
  has_many :piece_patterns
  has_many :pieces, through: :piece_patterns
end
