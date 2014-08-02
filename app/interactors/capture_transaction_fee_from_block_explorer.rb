class CaptureTransactionFeeFromBlockExplorer
  include Interactor

  def perform
    context[:transaction_with_fees] = []
    Payment.completed.without_transaction_fee.each do |payment|
      set_transaction_fee(payment)
    end
  end

  private
  def set_transaction_fee(payment)
    begin
      payment.transaction_fee = self.class.get_transaction_fee_from_parser(payment)
      payment.save
      context[:transaction_with_fees] << payment
    rescue => ex
      logger.info ex.message
    end
  end

  def self.get_transaction_fee_from_parser(payment)
    parser = BlockExplorerParser.new payment.transaction_hash, WebClient.new
    parser.parse
    parser.transaction_fee
  end
end
