class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :user_id
      t.string :brand_id  
    end
  end
end
