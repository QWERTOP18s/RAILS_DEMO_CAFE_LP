class AddUniqueIndexToProductsUid < ActiveRecord::Migration[7.0]
  def change
    add_index :products, :uid, unique: true
  end
end
