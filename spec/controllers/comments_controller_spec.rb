require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  describe "POST 'create'" do

    context "when user is not logged is" do
      it "redirects him" do
        post :create

        expect(response).to redirect_to root_path
      end
    end

    context "when user is logged in" do
      let(:user) { FactoryGirl.build(:user) }

      before do
        sign_in user
      end

      it "creates comment" do
        note = double(Note, id: 1, private?: false)
        comment_body = 'comment body'

        expect(Note).to receive(:find_by_id).with(note.id) { note }

        expect(CreateComment).to receive(:perform).with({note_id: note.id, comment_body: comment_body, user_id: user.id}) do
          double(CreateComment, success?: true, message: ["message"])
        end

        post :create, {comment_body: comment_body, note_id: note.id}

        expect(response).to be_success
        json = JSON.parse(response.body)
        expect(json["result"]).to be true
        expect(json["msg"]).not_to be_blank
      end

      it "shows error message when user try to add comment to someones private note" do
        note = double(Note, id: 1, private?: true, user_id: 123)
        expect(Note).to receive(:find_by_id).with(note.id) { note }

        post :create, {note_id: note.id}

        expect(response).to redirect_to root_path
      end
    end
  end

  describe "GET 'list'" do

    it "shows list of comments" do
      get :list, note_id: 1

      expect(response.status).to be_success
    end
  end
end
