class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.string :name
      t.string :size
      t.integer :user_id
      # t.integer :quantity ? if goes here, then quantity for all pieces, don't want that.
    end
  end
end
