require 'rails_helper'

describe CanPurchasePolicy do

  it "fails when user is not logged id" do
    policy = CanPurchasePolicy.perform({user: nil, note: double(Note)})

    expect(policy.allowed?).to be false
    expect(policy.redirect_to).to eq('log_in')
    expect(policy.message).not_to be_nil
  end

  it "fails when user already has access to note" do
    user = double(User)
    note = double(Note, id: 1)
    expect(user).to receive(:purchased?).once.with(note.id) { true }

    policy = CanPurchasePolicy.perform({user: user, note: note})

    expect(policy.allowed?).to be false
    expect(policy.redirect_to).to eq('already_purchased')
    expect(policy.message).not_to be_nil
  end

  it "success when user is logged in" do
    user = double(User)
    note = double(Note, id: 1)
    expect(user).to receive(:purchased?).once.with(note.id) { false }

    policy = CanPurchasePolicy.perform({user: user, note: note})

    expect(policy.allowed?).to be true
    expect(defined?(policy.redirect_to)).to be_nil
  end
end