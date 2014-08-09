require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do

  def mock_policy_allowed(controller, allowed)
    expect(controller).to receive(:policy_class) do
      double('comment_policy', perform: double('instance', allowed?: allowed, message: ''))
    end
  end

  describe "POST 'create'" do

    context "when user is NOT logged in" do
      it "redirects him to the home page" do
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

        mock_policy_allowed(controller, true)

        expect(CreateComment).to receive(:perform).with({note_id: note.id, comment_body: comment_body, user_id: user.id}) do
          double(CreateComment, success?: true, message: ["message"])
        end

        post :create, {comment_body: comment_body, note_id: note.id}

        expect(response).to be_success
        json = JSON.parse(response.body)
        expect(json["result"]).to be true
        expect(json["msg"]).not_to be_blank
      end

      it "shows error message when user tries to add comment to someones private note" do
        mock_policy_allowed(controller, false)

        note = double(Note, id: 1, private?: true, user_id: 123)

        post :create, {note_id: note.id}

        expect(response).to redirect_to root_path
      end
    end
  end

  describe "GET 'list'" do

    context 'when note has comments and user is allowed' do
      it 'shows comments' do
        note_id = 1

        mock_policy_allowed(controller, true)

        expect(GetCommentsForNote).to receive(:perform).with({note_id: note_id}) do
          double(GetCommentsForNote, comments: [double(Comment), double(Comment)])
        end

        get :list, note_id: note_id

        expect(response.status).to eq 200
        expect(response).to render_template(partial: "comments/_list")
        expect(assigns(:comments)).not_to be_empty
        expect(assigns(:comments)).to be_decorated
      end
    end

    context 'when note has comments and user is NOT allowed' do
      it 'redirects to the home page' do
        mock_policy_allowed(controller, false)

        get :list, note_id: 1

        expect(response).to redirect_to root_path
      end
    end
  end
end
