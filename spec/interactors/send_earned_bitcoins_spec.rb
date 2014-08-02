require 'rails_helper'

describe SendEarnedBitcoins do

  it 'sends earned bitcoints to note author' do
    payment = FactoryGirl.build(:completed_with_transaction_fee_payment, price: 100)
    payments = [payment]
    expect(payments).to receive(:with_transaction_fee) { payments }
    expect(payments).to receive(:not_settled) { payments }
    expect(Payment).to receive(:completed) { payments }

    note_author_share = 69.9
    expect(ShareCalculator).to receive(:new).with(payment.price, payment.transaction_fee) do
      double(ShareCalculator, owner_share: 30, note_author_share: note_author_share)
    end

    expect(Coinbase::Client).to receive(:new) do
      coinbase = double(Coinbase::Client)
      expect(coinbase).to receive(:send_money).with(payment.note.user.bitcoin_address, note_author_share, anything)
      coinbase
    end

    SendEarnedBitcoins.perform

  end

end