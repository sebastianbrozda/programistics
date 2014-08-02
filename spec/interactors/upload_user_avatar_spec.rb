require 'rails_helper'

describe UploadUserAvatar do

  it "updates user avatar" do
    user = FactoryGirl.build(:user)
    file = fixture_file_upload Rails.root.join('spec/files/rspec.png'), 'image/png'

    upload = UploadUserAvatar.perform({user: user, file: file})

    expect(upload.user.avatar).not_to be_nil
    expect(upload.success?).to be true
    expect(upload.message).to eq "Your avatar has changed"
  end
end