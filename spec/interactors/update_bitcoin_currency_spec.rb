require 'rails_helper'

describe UpdateBitcoinCurrency do
  it "updates bitcoin currency" do

    expect(Coinbase::Client).to receive(:new) do
      coinbase = double(Coinbase::Client)
      expect(coinbase).to receive(:sell_price).with(1) { 100 }
      coinbase
    end

    expect(Currency).to receive(:find_by_name).with('USD') { Currency.new }

    update_bitcoin = UpdateBitcoinCurrency.perform
    expect(update_bitcoin.usd.price).to eq 100
  end
end
