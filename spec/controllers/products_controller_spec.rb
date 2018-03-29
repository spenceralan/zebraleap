require 'rails_helper'

describe ProductsController do
  let!(:user) { create :user, email: 'test@example.com' }
  let!(:product) { create :product, name: 'Test Lesson', price_in_cents: 40000 }

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
        expect(JSON.parse(response.body)).to eq({ success: true }.to_json)
      end
    end

    context 'when the customer cannot be charged' do
      it 'responds with failure when the customer is not charged' do
        stub_successful_customer_create
        stub_unsuccessful_charge_create

        get :buy, params: {
          id: product.id,
          card_token: 'tok_test_card_token',
        }

        expect(response).to be_failure
        expect(JSON.parse(response.body)).to eq({ error: 'transaction failed' }.to_json)
      end
    end
  end
end

def stub_successful_customer_create
  stub_request(:post, 'http://localhost:12111/v1/customers').with(
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
  stub_request(:post, 'http://localhost:12111/v1/charges').with(
    body: {
      amount: '40000',
      currency: 'usd',
      source: 'cus_test_token',
      description: 'Purchase from Lessonly',
    },
    headers: {
      'Authorization' => 'Bearer sk_test_123'
    }
  ).to_return(body: successful_create_charge_response)
end

def stub_unsuccessful_charge_create
  stub_request(:post, 'http://localhost:12111/v1/charges').with(
    body: {
      amount: '40000',
      currency: 'usd',
      source: 'cus_test_token',
      description: 'Purchase from Lessonly',
    },
    headers: {
      'Authorization' => 'Bearer sk_test_123'
    }
  ).to_return(body: successful_create_charge_response, status: 400)
end

def successful_create_charge_response
  {
    "data": [
      {
        "amount": 100,
        "amount_refunded": 0,
        "balance_transaction": "txn_1BoJ2MKrZ43eBVAb7brIdCxb",
        "captured": false,
        "created": 1234567890,
        "currency": "usd",
        "customer": "cus_CQOEuf4BYRFqoC",
        "fraud_details": {},
        "id": "ch_1BoJ2MKrZ43eBVAbDNoY8Anc",
        "livemode": false,
        "metadata": {
          "instrument_id": "e2ca8185-4cd8-4a76-b053-0043bc181327"
        },
        "object": "charge",
        "outcome": {
          "network_status": "approved_by_network",
          "reason": nil,
          "risk_level": "normal",
          "seller_message": "Payment complete.",
          "type": "authorized"
        },
        "paid": true,
        "refunded": false,
        "refunds": {
          "data": [
            {
              "amount": 100,
              "balance_transaction": "txn_1C1TWH2eZvKYlo2CzFFds8B0",
              "charge": "ch_1BoJ2MKrZ43eBVAbDNoY8Anc",
              "created": 1234567890,
              "currency": "usd",
              "id": "re_1BoJ2MKrZ43eBVAb9MG5qna9",
              "metadata": {},
              "object": "refund",
              "status": "succeeded"
            }
          ],
          "has_more": false,
          "object": "list",
          "url": "/v1/charges/ch_1BoJ2MKrZ43eBVAbDNoY8Anc/refunds"
        },
        "source": {
          "id": "acct_1BoJ2AKrZ43eBVAb",
          "object": "account"
        },
        "status": "succeeded"
      }
    ],
    "has_more": false,
    "object": "list",
    "url": "/v1/charges",
  }.to_json
end

def successful_create_customer_response
  {
    "account_balance": 0,
    "created": 1234567890,
    "currency": "usd",
    "id": "cus_test_token",
    "invoice_prefix": "0edbba22b0",
    "livemode": false,
    "metadata": {},
    "object": "customer",
    "sources": {
      "data": [
        {
          "id": "acct_1BoJ2AKrZ43eBVAb",
          "object": "account"
        }
      ],
      "has_more": false,
      "object": "list",
      "url": "/v1/customers/cus_test_token/sources"
    },
    "subscriptions": {
      "data": [
        {
          "billing": "charge_automatically",
          "billing_cycle_anchor": 1234567890,
          "cancel_at_period_end": false,
          "canceled_at": 1234567890,
          "created": 1234567890,
          "current_period_end": 1234567890,
          "current_period_start": 1234567890,
          "customer": "cus_test_token",
          "ended_at": 1234567890,
          "id": "sub_CCiTraGt67ptj5",
          "items": {
            "data": [
              {
                "created": 1516918659,
                "id": "si_CCiTeY6cvtsSog",
                "metadata": {},
                "object": "subscription_item",
                "plan": {
                  "amount": 2000,
                  "created": 1516918654,
                  "currency": "usd",
                  "id": "gold",
                  "interval": "month",
                  "interval_count": 1,
                  "livemode": false,
                  "metadata": {},
                  "nickname": nil,
                  "object": "plan",
                  "product": "prod_BT1t06tZ3jBCHi"
                },
                "quantity": 1,
                "subscription": "sub_CCiT84TsYmPl2m"
              }
            ],
            "has_more": false,
            "object": "list",
            "url": "/v1/subscription_items?subscription=sub_CCiTraGt67ptj5"
          },
          "livemode": false,
          "metadata": {
            "foo": "bar"
          },
          "object": "subscription",
          "plan": {
            "amount": 2000,
            "created": 1516918654,
            "currency": "usd",
            "id": "gold",
            "interval": "month",
            "interval_count": 1,
            "livemode": false,
            "metadata": {},
            "nickname": nil,
            "object": "plan",
            "product": "prod_BURz485SkjnwD8"
          },
          "quantity": 1,
          "start": 1234567890,
          "status": "active",
          "trial_end": 1234567890,
          "trial_start": 1234567890
        }
      ],
      "has_more": false,
      "object": "list",
      "url": "/v1/customers/cus_test_token/subscriptions",
    }
  }.to_json
end
