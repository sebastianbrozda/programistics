require 'rails_helper'

describe CoinbaseCallbackValidator do

  context "when is invalid" do
    it 'fails when prices are not equal' do
      @validator = CoinbaseCallbackValidator.new(100, 200, 'completed')
    end

    it "fails with wrong status" do
      @validator = CoinbaseCallbackValidator.new(100, 100, 'other')
    end

    after(:each) do
      expect(@validator.valid?).to be false
      expect(@validator.errors).not_to be_empty
    end
  end

  it "success" do
    validator = CoinbaseCallbackValidator.new(100, 100, 'completed')
    expect(validator.valid?).to be true
  end
end