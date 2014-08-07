# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  user_name              :string(50)       not null
#  bitcoin_wallet         :string(50)
#  created_at             :datetime
#  updated_at             :datetime
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#

require 'rails_helper'

RSpec.describe User, :type => :model do

  context "validations" do
    it "fails with empty user name" do
      user = FactoryGirl.build(:user, user_name: '')
      user.save
      expect(user.errors).to include(:user_name)
    end

    it "fails with 2 the same user names" do
      user = FactoryGirl.build(:user, user_name: 'user_name')
      user.save
      expect(user.errors.size).to eq(0)

      user = FactoryGirl.build(:user, user_name: 'user_name')
      user.save
      expect(user.errors).to include(:user_name)
    end
  end

  it "adds favorite note" do
    user = FactoryGirl.create(:user)
    user.favorites << FactoryGirl.create(:note)
    expect(user.save).to eq(true)
    user.reload
    expect(user.favorites.size).to eq(1)
  end

  it "is note in favorites" do
    user = FactoryGirl.create(:user)
    note = FactoryGirl.create(:note, user: user)
    user.favorites << note
    expect(user.favorite_note? note.id).to be true
  end

  it "is note author" do
    user = FactoryGirl.create(:user)
    note = FactoryGirl.create(:note, user: user)
    expect(user.author? note.id).to be true
  end

  it "returns true when user has paid access to note" do
    user = FactoryGirl.create(:user)
    paid_access_note = FactoryGirl.create(:note, note_type: FactoryGirl.create(:paid_access_note_type))
    user.purchased << paid_access_note

    user.save
    user.reload

    expect(user.purchased?(paid_access_note.id)).to be true
  end

  describe '#bitcoin_address' do
    it "returns email when bitcoin_address is not present" do
      user = FactoryGirl.build(:user, bitcoin_wallet: nil)
      expect(user.bitcoin_address).to eq user.email
    end

    it "returns bitcoin wallet when it is present" do
      bitcoin_wallet = 'my bitcoin wallet address'
      user = FactoryGirl.build(:user, bitcoin_wallet: bitcoin_wallet)
      expect(user.bitcoin_address).to eq bitcoin_wallet
    end
  end
end
