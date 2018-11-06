class CreatePatterns < ActiveRecord::Migration
  def change
    create_table :patterns do |t|
      t.string :name
      # t.integer :quantity if quantity here, then quantity for all patterns, regardless of piece, don't want that either.
      t.integer :user_id
    end
  end
end
