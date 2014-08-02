require 'rails_helper'

describe MyEarningList do
  it "returns earnings" do
    user = double(User, id: 1)

    expect(Payment).to receive(:completed) do
      payments = [double(Payment, price: 10), double(Payment, price: 20)]
      expect(payments).to receive(:by_note_author_id).with(user.id) do
        payments
      end
      payments
    end

    earning_list = MyEarningList.perform({user: user})
    expect(earning_list.payments).not_to be_empty
    expect(earning_list.summary).to eq 30
  end
end