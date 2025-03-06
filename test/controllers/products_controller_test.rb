require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get products_path
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

  test 'should create product' do
    post products_path, params: { product: { name: 'Test Product', cost: 100, price: 150, category: 'Test Category', description: 'Test Description' } }
    assert_equal I18n.t('products.create.success'), flash[:success]
    assert_redirected_to product_path(Product.last)
  end

  test 'should update product' do
    patch product_path(products(:valid_product)), params: { product: { name: 'Updated Product' } }
    assert_equal I18n.t('products.update.success'), flash[:success]
    assert_redirected_to product_path(products(:valid_product))
  end

  test 'should destroy product' do
    delete product_path(products(:valid_product))
    assert_equal I18n.t('products.destroy.success'), flash[:success]
    assert_redirected_to products_path
  end
end
