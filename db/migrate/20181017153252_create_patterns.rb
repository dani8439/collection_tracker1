class CreatePatterns < ActiveRecord::Migration[4.2]
  def change
    create_table :patterns do |t|
      t.string :name
      t.integer :user_id
    end
  end
end
