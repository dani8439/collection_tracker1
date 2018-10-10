class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :user_id
      t.integer :piece_id
      t.string :piece_name
      t.integer :piece_id
      t.string :pattern_name
      t.string :quantity
    end
  end
end
