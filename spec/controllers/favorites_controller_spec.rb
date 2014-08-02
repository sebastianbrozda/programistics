require 'rails_helper'

RSpec.describe FavoritesController, :type => :controller do

  describe "POST 'add_note_to_favorites'" do
    it "adds note to favorites" do
      add_note_to_favorites = double(AddNoteToFavorites, success?: true, message: "success message")

      user = double(User)
      sign_in user
      note_id = 1

      expect(AddNoteToFavorites).to receive(:perform)
                                    .once
                                    .with({user: user, note_id: note_id}) { add_note_to_favorites }

      post :add_note_to_favorites, {note_id: note_id}


      expect(response.status).to eq(200)
      json = JSON.parse response.body
      expect(json["result"]).to eq(true)
      expect(json["msg"]).not_to be_nil
    end

    it "returns false when user try to add someones private note to favorite" do
      user = double(User, id: 2)
      sign_in user

      private_note = double(Note, id: 1, note_type_id: NoteType::TYPE_PRIVATE, user_id: 1)

      add_note = double(AddNoteToFavorites, success?: false, message: "")
      expect(AddNoteToFavorites).to receive(:perform)
                                    .once
                                    .with({user: user, note_id: private_note.id}) { add_note }

      post :add_note_to_favorites, :note_id => private_note.id

      json = JSON.parse(response.body)
      expect(json["result"]).to be false
      expect(json["msg"]).not_to be_nil
    end

  end

  describe "GET 'notes'" do
    it "shows list of favorite notes" do
      user = double(User)
      sign_in user

      user_favorite_note_list = double(UserFavoriteNoteList, notes: [])
      expect(UserFavoriteNoteList).to receive(:perform).with({user: user}).once { user_favorite_note_list }

      get :notes

      expect(response.status).to eq(200)
      expect(assigns[:notes]).not_to be_nil
    end

    it "removes note from favorites" do
      user = double(User)
      sign_in user
      note_id = 1

      remove_note = double(RemoveNoteFromFavorites, success?: true, message: "")
      expect(RemoveNoteFromFavorites).to receive(:perform).with({user: user, note_id: note_id}).once { remove_note }

      get :remove_note_from_favorites, {note_id: note_id}

      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["result"]).to be(true)
      expect(json["msg"]).not_to be_nil
    end

  end

end
