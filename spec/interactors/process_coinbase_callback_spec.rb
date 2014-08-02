require 'rails_helper'

describe ProcessCoinbaseCallback do
  context "received callback" do

    let(:order) { JSON.parse('{
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
}', symbolize_names: true)[:order] }

    let(:custom) { 'order1234' }
    let(:started_payment) { Payment.new custom: custom, status: Payment::STATUS_STARTED }
    let(:started_payments) { [started_payment] }

    it 'process coinbase callback with success' do
      expect(Payment).to receive(:started) { started_payments }
      expect(started_payment).to receive(:save) { true }
      expect(started_payments).to receive(:find_by_custom).with(custom) { started_payment }

      expect(CoinbaseCallbackValidator).to receive(:new).with(
                                               started_payment.price_in_cents,
                                               order[:status],
                                               order[:total_btc][:cents]) do
        double(CoinbaseCallbackValidator, valid?: true, errors: [])
      end

      process = ProcessCoinbaseCallback.perform({order: order})

      expect(process.success?).to eq true
      expect(process.payment.coinbase_order_id).to eq "5RTQNACF"
      expect(process.payment.status).to eq Payment::STATUS_VERIFIED
      expect(process.payment.transaction_hash).to eq "4a5e1e4baab89f3a32518a88c31bc87f618f76673e2cc77ab2127b7afdeda33b"
    end

    it "fails process when callback is invalid" do
      custom = 'order1234'

      expect(Payment).to receive(:started) { started_payments }
      expect(started_payments).to receive(:find_by_custom).with(custom) { started_payment }

      expect(CoinbaseCallbackValidator).to receive(:new).with(started_payment.price_in_cents,
                                                              order[:status],
                                                              order[:total_btc][:cents]) do
        double(CoinbaseCallbackValidator, valid?: false, errors: %w{err0 err1})
      end

      process = ProcessCoinbaseCallback.perform({order: order})
      expect(process.success?).to be false
    end
  end
end