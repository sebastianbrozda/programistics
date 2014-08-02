require 'rails_helper'

RSpec.describe MyEarningsController, :type => :controller do

  describe "GET #index" do
    let(:user) { double(User) }

    context "when user is logged in" do
      before do
        sign_in user
      end

      it "shows empty list" do
        expect(MyEarningList).to receive(:perform).with({user: user}) do
          double(MyEarningList, payments: [], summary: 0)
        end

        get :index

        expect(response).to be_success
        expect(assigns(:payments)).to be_empty
        expect(assigns(:summary)).to eq 0
      end

      it "shows list with summary" do
        expect(MyEarningList).to receive(:perform).with({user: user}) do
          double(MyEarningList, payments: [double(Payment)], summary: 100)
        end

        get :index

        expect(assigns(:payments)).not_to be_empty
        expect(assigns(:summary)).to eq 100
      end
    end

    context "when user is logged out" do
      it "redirects to login form" do
        get :index

        expect(response).to redirect_to new_user_session_path
      end
    end

  end

end
