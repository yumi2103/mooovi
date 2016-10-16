class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :image_url


      t.timestamps null: false
    end
  end
end
