require 'rails_helper'

describe BitcoinWalletValidator do

  context "when it is invalid" do
    it 'returns error' do
      validator = BitcoinWalletValidator.new '123'

      expect(validator.valid?).to be false
      expect(validator.errors).not_to be_empty
    end

    it "returns errors in one message" do
      validator = BitcoinWalletValidator.new '123'
      validator.valid?
      expect(validator.full_error_message).to eq "Bitcoin wallet address is not valid"
    end
  end

  context "when it is valid" do
    it "returns true without error messages" do
      validator = BitcoinWalletValidator.new '1N8EviejJ25T5FbiVb6CsAgPxQNAyYMob3'

      expect(validator.valid?).to be true
      expect(validator.errors).to be_empty
    end
  end

end