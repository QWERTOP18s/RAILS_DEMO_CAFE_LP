require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get products_index_url
    assert_response :success
  end

  test 'should get show' do
    get product_path(products(:valid_product))
    assert_response :success
  end

  test 'should get new' do
    get new_product_path
    assert_response :success
  end

  test 'should get edit' do
    get edit_product_path(products(:valid_product))
    assert_response :success
  end
end
