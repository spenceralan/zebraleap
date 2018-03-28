require 'net/http'

class ProductsController < ApplicationController
  def buy
    product = Product.find params[:id]
    card_token = params[:card_token]

    uri = URI 'http://localhost:12111/v1/customers'

    # Create customer based on card token
    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Post.new uri
      request['Authorization'] = 'Bearer sk_test_123' # set ZebraLeap password
      request.set_form_data({
        email: current_user.email,
        source: card_token,
      })

      response = http.request request

      if response.code != '200'
        render json: response.body && return
      end

      # TODO: get customer id from the response
    end

    uri = URI 'http://localhost:12111/v1/charges'

    # Charge customer
    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Post.new uri
      request['Authorization'] = 'Bearer sk_test_123' # set ZebraLeap password
      request.set_form_data({
        amount: product.price_in_cents,
        currency: 'usd',
        source: 'cus_CCiTI4Tpghl0nK', # customer id from above--hardcoded for now
        description: "Purchase of #{product.name}",
      })

      response = http.request request

      if response.code != '200'
        render json: response.body
      else
        if response.body =~ /"paid":true/
          render json: { success: true }
        else
          render json: { error: 'transaction failed' }
        end
      end
    end
  end
end
