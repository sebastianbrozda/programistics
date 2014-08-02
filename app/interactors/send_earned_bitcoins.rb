class SendEarnedBitcoins
  include Interactor

  def perform
    Payment.completed.with_transaction_fee.not_settled.each do |payment|
      share_calculator = ShareCalculator.new payment.price, payment.transaction_fee

      coinbase.send_money payment.note.user.bitcoin_address,
                          share_calculator.note_author_share,
                          self.class.message_to_seller(payment)
    end
  end

  private
  def coinbase
    @coinbase ||= Coinbase::Client.new(COINBASE_API_KEY, COINBASE_API_SECRET)
  end

  def self.message_to_seller(payment)
    "Someone purchased access to your note: #{payment.note.title}"
  end
end
