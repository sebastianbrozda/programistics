require 'rails_helper'

describe ShareCalculator do

  context 'splitting 100' do
    before(:each) do
      @calc = ShareCalculator.new 100, 1
    end

    it "returns 30 for owner" do
      expect(@calc.owner_share).to eq 30
    end

    it "returns 70 for note author" do
      expect(@calc.note_author_share).to eq 69
    end
  end

  context "splitting 99.99" do
    before(:each) do
      @calc = ShareCalculator.new 99.99, 1
    end

    it "returns 30 for owner" do
      expect(@calc.owner_share).to eq 30
    end

    it "returns 69.99 for note author" do
      expect(@calc.note_author_share).to eq 68.99
    end
  end
end