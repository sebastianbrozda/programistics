require 'rails_helper'

describe UpdateUserBitcoinWallet do

  let(:user) { FactoryGirl.build(:user, bitcoin_wallet: 'A') }
  let(:new_wallet) { '123' }

  it 'updates user bitcoin wallet number' do
    expect(user).to receive(:save)

    expect(BitcoinWalletValidator).to receive(:new) do
      double(BitcoinWalletValidator, valid?: true)
    end

    update = UpdateUserBitcoinWallet.perform({user: user, wallet: new_wallet})

    expect(update.success?).to be true
    expect(update.message).not_to be_blank
  end

  it 'fails with error message' do
    expect(BitcoinWalletValidator).to receive(:new) do
      double(BitcoinWalletValidator, valid?: false, full_error_message: 'error')
    end

    update = UpdateUserBitcoinWallet.perform({user: user, wallet: new_wallet})

    expect(update.success?).to be false
    expect(update.message).not_to be_blank
  end
end