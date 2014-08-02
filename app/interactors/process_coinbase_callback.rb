class ProcessCoinbaseCallback
  include Interactor

  def perform

    payment = Payment.started.find_by_custom order[:custom]

    validator = CoinbaseCallbackValidator.new(payment.price_in_cents,
                                              order[:status],
                                              order[:total_btc][:cents])

    unless validator.valid?
      fail!(messages: validator.errors)
      return
    end

    payment.coinbase_order_id = order[:id]
    payment.transaction_hash = order[:transaction][:hash]
    payment.status = Payment::STATUS_VERIFIED
    payment.save

    context[:payment] = payment
  end
end
