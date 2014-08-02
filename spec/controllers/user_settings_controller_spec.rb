require 'rails_helper'

RSpec.describe UserSettingsController, :type => :controller do

  let(:user) { double(User) }
  before do
    sign_in user
  end

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end

    it "redirects when user is not logged in" do
      sign_out
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "POST 'update_email'" do
    it "updates user email" do
      new_email = "mynewemail@example.com"

      expect(UpdateUserEmail).to receive(:perform).with({user: user, email: new_email}) do
        double(UpdateUserEmail, success?: true, message: 'message')
      end

      post :update_email, email: new_email

      json = JSON.parse(response.body)
      expect(json["result"]).to be true
      expect(json["msg"]).not_to be_blank
    end
  end

  describe "POST 'update_bitcoin_wallet'" do
    it "updates bitcoin wallet number" do
      wallet = '123321'

      expect(UpdateUserBitcoinWallet).to receive(:perform).with(user: user, wallet: wallet) do
        double(UpdateUserBitcoinWallet, success?: true, message: 'message')
      end

      post :update_bitcoin_wallet, wallet: wallet

      json = JSON.parse(response.body)
      expect(json["result"]).to be true
      expect(json["msg"]).not_to be_blank
    end
  end

  describe "POST 'upload_avatar'" do
    let(:file) { "mock" }

    after do
      expect(response).to redirect_to user_settings_path
    end

    it "updates user avatar" do
      expect(UploadUserAvatar).to receive(:perform).with({user: user, file: file}) do
        double(UploadUserAvatar, success?: true, message: 'ok')
      end

      post :upload_avatar, file: file

      expect(flash[:notice]).not_to be_blank
    end

    it "not update user avatar with invalid image" do
      expect(UploadUserAvatar).to receive(:perform).with({user: user, file: file}) do
        double(UploadUserAvatar, success?: false, message: 'ok')
      end

      post :upload_avatar, file: file

      expect(flash[:alert]).not_to be_blank
    end
  end

end