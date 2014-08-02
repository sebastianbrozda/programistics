require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  describe "POST 'create'" do

    context "when user is logged in" do
      let(:user) { FactoryGirl.build(:user) }

      before do
        sign_in user
      end

      it "creates comment" do
        note_id = 1
        comment_body = 'comment body'

        expect(CreateComment).to receive(:perform).with({note_id: note_id, comment_body: comment_body, user_id: user.id}) do
          double(CreateComment, success?: true, message: ["message"])
        end

        post :create, {comment_body: comment_body, note_id: note_id}

        expect(response).to be_success
        json = JSON.parse(response.body)
        expect(json["result"]).to be true
        expect(json["msg"]).not_to be_blank
      end

      it "shows error message when user try to add comment to private note" do

      end
    end
  end
end
