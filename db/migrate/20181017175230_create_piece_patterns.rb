class CreatePiecePatterns < ActiveRecord::Migration[4.2]
  def change
    create_table :piece_patterns do |t|
      t.integer :piece_id
      t.integer :pattern_id
    end
  end
end
