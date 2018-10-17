class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.string :name
      t.string :size
      t.integer :quantity
      t.integer :pattern_id
      t.integer :user_id
    end
  end
end
