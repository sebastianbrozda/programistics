class CoinbaseCallbackValidator
  include ActiveModel::Validations

  validate :prices
  validate :status

  def initialize(payment_price, order_price, order_status)
    @payment_price, @order_price, @order_status = payment_price, order_price, order_status
  end

  private
  attr_reader :payment_price
  attr_reader :order_status
  attr_reader :order_price

  def prices
    errors[:base] << "Prices are not equal!" if payment_price != order_price
  end

  def status
    errors[:base] << "Wrong status! Should be started but it is #{order_status}" if order_status != 'completed'
  end
end