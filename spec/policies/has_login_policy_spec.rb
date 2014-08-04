require 'rails_helper'

describe HasLoginPolicy do

  it "fails when user is NOT logged in" do
    policy = HasLoginPolicy.perform({user: nil})

    expect(policy.allowed?).to eq(false)
  end

  it "success when user is logged in" do
    policy = HasLoginPolicy.perform({user: double(User)})

    expect(policy.allowed?).to eq(true)
  end

end