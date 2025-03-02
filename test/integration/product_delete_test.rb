require 'test_helper'

class ProductDeleteTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:valid_product)
  end

  test 'delete product' do
    assert_difference 'Product.count', -1 do
      delete product_path(@product)
    end
  end
end
