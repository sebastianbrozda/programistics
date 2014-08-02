require 'rails_helper'

describe AddPuchasedAccessToUser do

  it "adds access to user" do
    user = FactoryGirl.build(:user)
    note = FactoryGirl.build(:note)
    expect(user.purchased).to receive(:<<).with(note)

    expect(Payment).to receive(:verified) do
      completed_payment = FactoryGirl.build(:verified_payment, user: user, note: note)
      expect(completed_payment).to receive(:save)
      completed_payments = [completed_payment]
      completed_payments
    end

    add_access = AddPuchasedAccessToUser.perform

    expect(add_access.completed_payments.size).to eq 1
  end

end