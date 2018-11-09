class CreatePiecePatterns < ActiveRecord::Migration
  def change
    create_table :piece_patterns do |t|
      t.integer :piece_id
      t.integer :pattern_id
      t.integer :quantity
      t.integer :user_id
    end
  end
end
