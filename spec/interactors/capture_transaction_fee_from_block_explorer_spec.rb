require 'rails_helper'

describe CaptureTransactionFeeFromBlockExplorer do

  def expect_payment_to_receive_completed(transactions)
    expect(transactions).to receive(:without_transaction_fee) { transactions }
    expect(Payment).to receive(:completed) { transactions }
  end


  it 'gets transaction fee from block explorer' do
    transaction = FactoryGirl.build(:completed_without_transaction_fee_payment, transaction_hash: '1234abcd')
    expect(transaction).to receive(:save)

    expect_payment_to_receive_completed [transaction]

    web_client = double(WebClient)
    expect(WebClient).to receive(:new).once { web_client }

    expect(BlockExplorerParser).to receive(:new).with(transaction.transaction_hash, web_client) do
      parser = double(BlockExplorerParser, transaction_fee: 1)
      expect(parser).to receive(:parse)
      parser
    end

    capture = CaptureTransactionFeeFromBlockExplorer.perform

    expect(capture.transaction_with_fees.size).to eq 1
    expect(capture.transaction_with_fees.first.transaction_fee).to eq transaction.transaction_fee
  end

  it "takes next transaction after error" do
    transaction1 = FactoryGirl.build(:completed_without_transaction_fee_payment, transaction_hash: '1234abcd')
    transaction2 = FactoryGirl.build(:completed_without_transaction_fee_payment, transaction_hash: '4321abcd')
    expect(transaction2).to receive(:save)

    expect_payment_to_receive_completed [transaction1, transaction2]

    web_client = double(WebClient)
    expect(WebClient).to receive(:new).twice { web_client }

    expect(BlockExplorerParser).to receive(:new).with(transaction1.transaction_hash, web_client) do
      parser = double(BlockExplorerParser)
      expect(parser).to receive(:parse) { raise 'error' }
      parser
    end

    expect(BlockExplorerParser).to receive(:new).with(transaction2.transaction_hash, web_client) do
      parser = double(BlockExplorerParser, transaction_fee: 1)
      expect(parser).to receive(:parse)
      parser
    end

    logger = double('logger')
    expect(logger).to receive(:info)

    CaptureTransactionFeeFromBlockExplorer.perform({logger: logger})
  end
end