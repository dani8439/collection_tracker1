class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.string :name
      t.string :size
      t.integer :quantity
      t.string :pattern
      t.integer :user_id
    end
  end
end
