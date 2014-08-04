# == Schema Information
#
# Table name: payments
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  note_id           :integer          not null
#  status            :integer          not null
#  settled           :boolean          default(FALSE)
#  custom            :string(40)       not null
#  price             :decimal(12, 8)   default(0.0)
#  coinbase_order_id :string(255)
#  transaction_hash  :string(255)
#  transaction_fee   :decimal(12, 8)
#  created_at        :datetime
#  updated_at        :datetime
#

require 'rails_helper'

RSpec.describe Payment, :type => :model do

  it "returns price in cents" do
    p = FactoryGirl.build(:started_payment, price: 100)

    expect(p.price_in_cents).to eq 10_000_000_000
  end

  describe "finders" do
    let(:user) { FactoryGirl.create(:user) }
    let(:note) { FactoryGirl.create(:note, user: user) }

    before(:each) do
      FactoryGirl.create(:started_payment, note: note)
      FactoryGirl.create(:verified_payment)
      FactoryGirl.create(:verified_payment)
      FactoryGirl.create(:completed_payment)
      FactoryGirl.create(:completed_with_transaction_fee_payment)
      FactoryGirl.create(:completed_unsettled_payment)
      FactoryGirl.create(:completed_with_transaction_fee_payment)
    end

    it "returns only started payments" do
      expect(Payment.started.size).to eq 1
    end

    it "returns only verified payments" do
      expect(Payment.verified.size).to eq 2
    end

    it "returns only completed payments" do
      expect(Payment.completed.size).to eq 4
    end

    it "returns only not settlet payments" do
      expect(Payment.not_settled.size).to eq 7
    end

    it "returns only without transaction fee" do
      expect(Payment.with_transaction_fee.size).to eq 2
    end

    it "returns only transaction by note author" do
      expect(Payment.by_note_author_id(777)).to be_empty
      expect(Payment.by_note_author_id(user.id).size).to eq 1
    end
  end

  it "complete payment" do
    payment = FactoryGirl.build(:started_payment)

    payment.complete!

    expect(payment.user.purchased.size).to eq 1
    expect(payment.completed?).to be true
  end

  it "starts payment" do
    user_id = 1
    custom = 'custom'
    note = double(Note, id: 1, price_for_access: 100)

    payment = FactoryGirl.build(:payment)

    payment.start! custom, user_id, note

    expect(payment.custom).to eq custom
    expect(payment.user_id).to eq user_id
    expect(payment.note_id).to eq note.id
    expect(payment.started?).to eq true
    expect(payment.settled).to eq false
    expect(payment.price).to eq note.price_for_access
    expect(payment.custom).to eq custom
  end

end
