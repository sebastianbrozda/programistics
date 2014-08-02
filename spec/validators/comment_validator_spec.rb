require 'rails_helper'

describe CommentValidator do

  it "is invalid with too short comment" do
    validator = CommentValidator.new double('comment', comment: 'abc', user: double('user'))

    expect(validator.valid?).to be false
    expect(validator.errors[:comment]).not_to be_blank
  end

  it "is invalid without user id" do
    validator = CommentValidator.new double('comment', comment: 'normal comment', user: nil)

    expect(validator.valid?).to be false
    expect(validator.errors[:user]).not_to be_blank
  end
end