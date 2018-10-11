class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.integer :user_id
      t.integer :pattern_id
      t.integer :piece_id
      t.integer :quantity
    end
  end
end
