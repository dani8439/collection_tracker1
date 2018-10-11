class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.string :name
      t.string :size
      t.integer :pattern_id
    end
  end
end
