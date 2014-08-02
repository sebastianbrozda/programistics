require 'rails_helper'

describe StartPayment do

  it 'creates payment' do
    note = double(Note, id: 1)
    user = double(User, id: 10)
    custom = 'custom'

    expect(Payment).to receive(:new) do
      payment = double(Payment, start!: true)
      expect(payment).to receive(:start!).with(custom, user.id, note)
      payment
    end

    begin_payment = StartPayment.perform({note: note, user: user, custom: custom})
    expect(begin_payment.payment).not_to be_nil
  end

end