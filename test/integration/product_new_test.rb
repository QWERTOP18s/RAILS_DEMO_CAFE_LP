require 'test_helper'
require 'securerandom'

class ProductNewTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:valid_product)
  end

  test 'valid create product' do
    get new_product_path
    assert_difference 'Product.count', 1 do
      post products_path, params: { product: @product.attributes }
    end
    assert_redirected_to product_path(Product.last)
  end

  test 'invalid create product with missing name' do
    get new_product_path
    product = @product.dup
    product.name = ''
    assert_no_difference 'Product.count' do
      post products_path, params: { product: product.attributes }
    end
    assert_template 'products/new'
    assert_response :unprocessable_entity
  end

  test 'invalid create product with invalid file' do
    get new_product_path

    # テスト用のPDFファイルを準備
    pdf_file = fixture_file_upload(
      Rails.root.join('test/fixtures/files/invalid_file_ex.pdf'),
      'application/pdf'
    )

    assert_no_difference 'Product.count' do
      post products_path, params: {
        product: @product.attributes.merge(
          ref: pdf_file
        ),
      }
    end

    assert_template 'products/new'
    assert_response :unprocessable_entity
  end
end
