require 'rails_helper'

describe HasLoginPolicy do

  it "fails when user is NOT logged in" do
    has_login_policy = HasLoginPolicy.perform({user: nil})
    expect(has_login_policy.allowed?).to eq(false)
  end

  it "success when user is logged in" do
    has_login_policy = HasLoginPolicy.perform({user: double(User)})
    expect(has_login_policy.allowed?).to eq(true)
  end

end