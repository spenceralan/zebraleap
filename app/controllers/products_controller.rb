require 'net/http'

class ProductsController < ApplicationController
  def buy
    product = Product.find params[:id]
    card_token = params[:card_token]

    uri = URI 'http://localhost:12111/v1/customers'
    customer_id = nil

    # Create customer in ZebraLeap based on card token
    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Post.new uri
      request['Authorization'] = 'Bearer sk_test_123' # set ZebraLeap password
      request.set_form_data({
        email: current_user.email,
        source: card_token,
      })

      response = http.request request

      if response.code != '200'
        render json: response.body
        return
      end

      customer_id = JSON.parse(response.body)['id']
    end

    uri = URI 'http://localhost:12111/v1/charges'

    # Charge user
    Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Post.new uri
      request['Authorization'] = 'Bearer sk_test_123' # set ZebraLeap password
      request.set_form_data({
        amount: product.price_in_cents,
        currency: 'usd',
        source: customer_id,
        description: 'Purchase from Lessonly',
      })

      response = http.request request

      if response.code != '200'
        render json: { error: 'transaction failed' }
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
