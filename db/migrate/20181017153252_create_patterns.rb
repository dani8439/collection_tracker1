class CreatePatterns < ActiveRecord::Migration
  def change
    create_table :patterns do |t|
      t.string :name
      t.integer :quantity
      t.integer :piece_id
    end
  end
end
