require 'test_helper'
require 'securerandom'
class ProductTest < ActiveSupport::TestCase
  def setup
    @product = Product.new(uid: SecureRandom.uuid, name: 'Test Product', cost: 100, price: 150, category: 'Test Category', description: 'Test Description')
  end

  test 'should be valid' do
    assert @product.valid?
  end

  # name

  test 'name should be present' do
    @product.name = '     '
    assert_not @product.valid?
  end

  test 'name should not be too long' do
    @product.name = 'a' * 51
    assert_not @product.valid?
  end

  test 'name should not be too short' do
    @product.name = 'a' * 2
    assert_not @product.valid?
  end

  # cost & price

  test 'cost should be present' do
    @product.cost = nil
    assert_not @product.valid?
  end

  test 'price should be positive' do
    @product.price = -1
    assert_not @product.valid?
  end

  test 'category should be present' do
    @product.category = nil
    assert_not @product.valid?
  end

  test 'uid should be unique' do
    duplicate_product = @product.dup
    @product.save
    assert_not duplicate_product.valid?
  end

  test 'description should be present' do
    @product.description = '     '
    assert_not @product.valid?
  end

  test 'ref should be valid' do
    @product.ref.attach(io: Rails.root.join('test/fixtures/files/test.jpeg').open, filename: 'test.jpeg', content_type: 'image/jpeg')
    assert @product.valid?
  end

  test 'ref should be invalid' do
    @product.ref.attach(io: Rails.root.join('test/fixtures/files/invalid_file_ex.pdf').open, filename: 'invalid_file_ex.pdf', content_type: 'application/pdf')
    assert_not @product.valid?
  end
end
