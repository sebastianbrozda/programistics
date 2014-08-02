class UpdateUserBitcoinWallet
  include Interactor

  def perform
    validator = BitcoinWalletValidator.new wallet

    unless validator.valid?
      fail!(message: validator.full_error_message)
      return
    end

    user.bitcoin_wallet = wallet
    user.save

    context[:message] = "Bitcoin wallet number has been changed"
  end
end
