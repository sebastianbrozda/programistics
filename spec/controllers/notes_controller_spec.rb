require 'rails_helper'

RSpec.describe NotesController, :type => :controller do

  describe "GET 'new'" do
    context "user is logged in" do
      it "shows form" do
        sign_in

        get :new

        expect(response.status).to eq(200)
        expect(assigns[:note]).not_to be_nil
        expect(assigns[:note_types]).not_to be_nil
      end
    end

    context "user is logged out" do
      it "redirects when user is NOT logged in" do
        get :new

        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end

  describe "POST 'create'" do
    before do
      sign_in
    end

    def action
      post :create, {note: {title: 'title', body: 'body', note_type_id: 1}}
    end

    context "with valid attributes" do
      it "creates the new note" do
        note = double(Note, id: 1)
        create_note = double('create_note', :success? => true, note: note)
        expect(CreateNote).to receive(:perform).and_return(create_note)

        action

        expect(assigns[:note]).not_to be_nil
        expect(response).to redirect_to(note_path(note))
        expect(flash[:notice]).not_to be_nil
      end
    end

    context "with invalid attributes" do
      it "shows message error" do
        note = double(Note)
        create_note = double('create_note', success?: false, note: note)
        expect(CreateNote).to receive(:perform).and_return(create_note)

        action

        expect(response).to render_template :new
        expect(assigns[:note]).not_to be_nil
        expect(assigns[:note_types]).not_to be_nil
      end
    end
  end

  describe "GET 'show'" do
    it "shows note" do
      note = double(Note, id: 1)
      show_note = double('show_note', note: note)
      expect(ReturnNoteBySlugAndId).to receive(:perform).with({id: 'title1,1'}) { show_note }

      get :show, id: 'title1,1'

      expect(assigns[:note]).not_to be_nil
      expect(assigns[:note]).to be_decorated
      expect(response.status).to eq(200)
    end
  end

  describe "GET 'my_own'" do
    it "redirects to log in form if user is NOT logged in" do
      get :my_own

      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_path)
    end

    it "shows all my own notes" do
      user = double(User)
      sign_in user

      notes = (1..3).map { |id| double(Note, id: id) }
      show_all_own_notes = double(ShowAllMyOwnNotes)
      expect(show_all_own_notes).to receive(:notes) { notes }
      expect(ShowAllMyOwnNotes).to receive(:perform).with({user: user}) { show_all_own_notes }

      get :my_own

      expect(response.status).to eq(200)
      expect(assigns[:notes].size).to eq(notes.size)
      expect(assigns[:notes]).to be_decorated
    end
  end
end
