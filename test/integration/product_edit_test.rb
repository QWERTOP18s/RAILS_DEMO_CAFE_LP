require 'test_helper'
require 'securerandom'

class ProductEditTest < ActionDispatch::IntegrationTest
  setup do
    @valid_product = products(:valid_product)
  end

  test 'valid edit product' do
    get edit_product_path(@valid_product)

    assert_response :success
  end

  test 'invalid edit product with missing name' do
    name = @valid_product.name
    description = @valid_product.description
    @valid_product.name = ''

    get edit_product_path(@valid_product)
    assert_template 'products/edit'

    patch product_path(@valid_product), params: { product: @valid_product.attributes }

    # データベースのデータを更新しない
    @valid_product.reload
    assert_equal name, @valid_product.name
    assert_equal description, @valid_product.description

    assert_template 'products/edit'
    assert_response :unprocessable_entity
  end
end
