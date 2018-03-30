require 'rails_helper'

describe ProductsController do
  let! :user do
    create :user, email: 'test@example.com'
  end

  let! :product do
    create :product, name: 'Test Lesson', price_in_cents: 40000
  end

  describe 'GET #buy' do
    context 'when the customer is charged successfully' do
      it 'responds with success' do
        stub_successful_customer_create
        stub_successful_charge_create

        get :buy, params: {
          id: product.id,
          card_token: 'tok_test_card_token',
        }

        expect(response).to be_success
        expect(response.body).to eq({ success: true }.to_json)
      end
    end

    context 'when the customer cannot be charged' do
      it 'responds with failure status code and message when the customer is not charged' do
        stub_successful_customer_create
        stub_unsuccessful_charge_create

        get :buy, params: {
          id: product.id,
          card_token: 'tok_test_card_token',
        }

        expect(response).to have_http_status(200)
        expect(response.body).to eq({ error: 'transaction failed' }.to_json)
      end
    end
  end
end

########################################################################
########################################################################
######### You should not need to modify any of the code below! #########
########################################################################
########################################################################

def stub_successful_customer_create
  stub_request(:post, 'http://zebraleap-simple-test.herokuapp.com/v1/customers').with(
    body: {
      email: 'test@example.com',
      source: 'tok_test_card_token'
    },
    headers: {
      'Authorization' => 'Bearer sk_test_123'
    }
  ).to_return(body: successful_create_customer_response)
end

def stub_successful_charge_create
  stub_request(:post, 'http://zebraleap-simple-test.herokuapp.com/v1/charges').with(
    body: {
      amount: '40000',
      currency: 'usd',
      source: 'cus_test_token',
      description: 'Purchase from Lessonly',
    },
    headers: {
      'Authorization' => 'Bearer sk_test_123'
    }
  ).to_return(body: create_charge_response)
end

def stub_unsuccessful_charge_create
  stub_request(:post, 'http://zebraleap-simple-test.herokuapp.com/v1/charges').with(
    body: {
      amount: '40000',
      currency: 'usd',
      source: 'cus_test_token',
      description: 'Purchase from Lessonly',
    },
    headers: {
      'Authorization' => 'Bearer sk_test_123'
    }
  ).to_return(body: create_charge_response, status: 400)
end

def create_charge_response
  {
    "data": [
      {
        "amount": 40000,
        "amount_refunded": 0,
        "balance_transaction": "txn_1BoJ2MKrZ43eBVAb7brIdCxb",
        "captured": false,
        "currency": "usd",
        "customer": "cus_test_token",
        "fraud_details": {},
        "id": "ch_1BoJ2MKrZ43eBVAbDNoY8Anc",
        "livemode": false,
        "object": "charge",
        "outcome": {
          "network_status": "approved_by_network",
          "reason": nil,
          "risk_level": "normal",
          "seller_message": "Payment complete.",
          "type": "authorized"
        },
        "paid": true,
        "status": "succeeded"
      }
    ],
  }.to_json
end

def successful_create_customer_response
  {
    "id": "cus_test_token",
    "object": "customer",
  }.to_json
end
