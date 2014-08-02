require 'rails_helper'

describe UpdateUserEmail do
  let(:user) { FactoryGirl.build(:user) }
  let(:new_email) { "email_new@example.com" }

  it 'updates user email with success' do
    expect(user).to receive(:save) { true }

    update = UpdateUserEmail.perform({user: user, email: new_email})
    expect(update.success?).to be true
    expect(update.message).not_to be_blank
  end

  it 'updates fail with error message' do
    expect(user).to receive(:save) { false }

    update = UpdateUserEmail.perform({user: user, email: new_email})
    expect(update.success?).to be false
    expect(update.message).not_to be_blank
  end


end