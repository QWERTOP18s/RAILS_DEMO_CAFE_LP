class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      
      t.string :uid
      t.string :name
      t.decimal :cost
      t.decimal :price
      t.string :ref
      t.text :description
      t.string :category

      t.timestamps
    end
  end
end
