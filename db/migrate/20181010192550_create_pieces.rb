class CreatePieces < ActiveRecord::Migration[4.2]
  def change
    create_table :pieces do |t|
      t.string :name
      t.string :size
      t.integer :user_id
    end
  end
end
