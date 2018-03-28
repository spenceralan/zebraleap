require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get buy" do
    get products_buy_url
    assert_response :success
  end

end
