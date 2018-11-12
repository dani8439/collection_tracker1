class CreateWishlists < ActiveRecord::Migration
  def change
    create_table :wishlist do |t|
      t.integer :user_id
      t.string :pattern_name
      t.string :piece_name
      t.string :piece_size
      t.integer :quantity
    end
  end
end
