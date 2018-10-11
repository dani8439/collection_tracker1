class Pattern < ActiveRecord::Base
  has_many :collections
  has_many :pieces, through: :collections
end
