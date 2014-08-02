require 'rails_helper'

RSpec.describe PaymentNotificationController, :type => :controller do

  let(:json_callback) { JSON.parse('{
  "order": {
    "id": "5RTQNACF",
    "created_at": "2012-12-09T21:23:41-08:00",
    "status": "completed",
    "event": {
      "type": "completed"
    },
    "total_btc": {
      "cents": "100000000",
      "currency_iso": "BTC"
    },
    "total_native": {
      "cents": "1253",
      "currency_iso": "USD"
    },
    "total_payout": {
      "cents": "2345",
      "currency_iso": "USD"
    },
    "custom": "order1234",
    "receive_address": "1NhwPYPgoPwr5hynRAsto5ZgEcw1LzM3My",
    "button": {
      "type": "buy_now",
      "name": "Alpaca Socks",
      "description": "The ultimate in lightweight footwear",
      "id": "5d37a3b61914d6d0ad15b5135d80c19f"
    },
    "transaction": {
      "id": "514f18b7a5ea3d630a00000f",
      "hash": "4a5e1e4baab89f3a32518a88c31bc87f618f76673e2cc77ab2127b7afdeda33b",
      "confirmations": "0"
    },
    "customer": {
      "email": "coinbase@example.com",
      "shipping_address": [
        "John Smith",
        "123 Main St.",
        "Springfield, OR 97477",
        "United States"
      ]
    },
    "refund_address": "1HcmQZarSgNuGYz4r7ZkjYumiU4PujrNYk"
  }
}') }


  describe "GET 'codebase'" do
    it "process codebase with success" do
      process_callback = double(ProcessCoinbaseCallback, success?: true)
      expect(ProcessCoinbaseCallback).to receive(:perform).once.with({order: json_callback["order"]}) { process_callback }

      get :coinbase, json_callback

      expect(response.status).to eq 200
      expect(response.body).to eq "ok"
    end

    it "process with error" do
      process_callback = double(ProcessCoinbaseCallback, success?: false, errors: ["err0"])
      expect(ProcessCoinbaseCallback).to receive(:perform).once.with({order: json_callback["order"]}) { process_callback }

      get :coinbase, json_callback

      expect(response.status).to eq 500
    end
  end


end
