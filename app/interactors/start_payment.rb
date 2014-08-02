class StartPayment
  include Interactor

  def perform
    payment = Payment.new
    payment.start! custom, user.id, note
    context[:payment] = payment
  end
end
