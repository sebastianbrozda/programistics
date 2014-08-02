class ShareCalculator

  def initialize(price, transaction_fee)
    @price = price
    @transaction_fee = transaction_fee
  end

  def note_author_share
    ((price * SHARE_FOR_NOTE_AUTHOR) - transaction_fee).round(2)
  end

  def owner_share
    price - note_author_share - transaction_fee
  end

  private
  attr_reader :price
  attr_reader :transaction_fee

  SHARE_FOR_NOTE_AUTHOR = 0.7
end