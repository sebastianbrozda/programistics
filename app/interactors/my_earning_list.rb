class MyEarningList
  include Interactor

  def perform
    payments = Payment.completed.by_note_author_id user.id
    context[:payments] = payments
    context[:summary] = self.class.get_payment_summary(payments)
  end

  private
  def self.get_payment_summary(payments)
    payments.map { |payment| payment.price }.inject(:+)
  end
end
