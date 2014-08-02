# this validation code has been taken and changed from https://gist.github.com/alexandrz/4491729

class BitcoinWalletValidator
  require 'digest'

  include ActiveModel::Validations

  validate :wallet_address

  def initialize(wallet)
    @wallet = wallet
  end

  def full_error_message
    errors.full_messages.join(', ') unless errors.empty?
  end

  private
  attr_reader :wallet

  B58Chars = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz'
  B58Base = B58Chars.length

  def wallet_address
    errors[:base] << "Bitcoin wallet address is not valid" unless (wallet =~ /^[a-zA-Z1-9]{33,35}$/) && version
  end

  def version
    decoded = self.class.b58_decode(wallet, 25)

    version = decoded[0, 1]
    checksum = decoded[-4, decoded.length]
    vh160 = decoded[0, decoded.length - 4]

    hashed = (Digest::SHA2.new << (Digest::SHA2.new << vh160).digest).digest

    hashed[0, 4] == checksum ? version[0] : nil
  end

  def self.b58_decode(value, length)
    long_value = 0
    index = 0
    result = ""

    value.reverse.each_char do |char|
      long_value += B58Chars.index(char) * (B58Base ** index)
      index += 1
    end

    while long_value >= 256 do
      div, mod = long_value.divmod 256
      result = mod.chr + result
      long_value = div
    end

    result = long_value.chr + result

    if result.length < length
      result = 0.chr * (length - result.length) + result
    end

    result
  end
end