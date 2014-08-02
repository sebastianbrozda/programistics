class AddPuchasedAccessToUser
  include Interactor

  def perform
    context[:completed_payments] = []

    Payment.verified.each do |payment|
      payment.complete!
      context[:completed_payments] << payment
    end
  end
end
