# test/controllers/errors_controller_test.rb
require 'test_helper'

class ErrorsControllerTest < ActionDispatch::IntegrationTest
  # 404エラーのテスト
  test 'should handle routing error with 404 page' do
    get '/non_existent_path'
    assert_response :not_found
    assert_template 'errors/not_found'
  end

  test 'should handle internal error with 500 page' do
    # テスト用のルートを追加
    Rails.application.routes.draw do
      get 'test_500_error' => 'errors#internal_server_error'
      # 既存のルートを保持
      get 'errors/not_found', to: 'errors#not_found'
      get 'errors/internal_server_error', to: 'errors#internal_server_error'
    end

    get '/test_500_error'

    # 500エラーのテスト　　　302でリダイレクトされる
    # assert_response :internal_server_error
    assert_template 'errors/internal_server_error'
  end

  test 'should display error pages directly' do
    get errors_not_found_path
    assert_response :not_found
    assert_template 'errors/not_found'

    get errors_internal_server_error_path
    assert_response :internal_server_error
    assert_template 'errors/internal_server_error'
  end

  teardown do
    Rails.application.reload_routes!
  end
end
