class CreatePatterns < ActiveRecord::Migration
  def change
    create_table :patterns do |t|
      t.string :name
      t.string :theme
      t.string :user_id
    end
  end
end
