class UpdateBitcoinCurrency
  include Interactor

  ONE_BITCOIN = 1

  def perform
    usd = Currency.find_by_name 'USD'
    usd.price = coinbase.sell_price ONE_BITCOIN
    usd.save
    context[:usd] = usd
  end

  private
  def coinbase
    @coinbase ||= Coinbase::Client.new(COINBASE_API_KEY, COINBASE_API_SECRET)
  end
end
