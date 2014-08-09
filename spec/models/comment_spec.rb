require 'rails_helper'

RSpec.describe Comment, :type => :model do

  describe "#author" do
    it "returns author of comment" do
      c = Comment.new({user: FactoryGirl.build(:user, user_name: 'author')})
      expect(c.author).to eq 'author'
    end
  end

end
