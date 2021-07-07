class CreateWishlists < ActiveRecord::Migration[4.2]
  def change
    create_table :wishlists do |t|
      t.integer :user_id
      t.string :pattern_name
      t.string :piece_name
      t.string :piece_size
      t.integer :quantity
    end
  end
end
