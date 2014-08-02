require 'rails_helper'

RSpec.describe HomeController, :type => :controller do
  describe "GET 'index'" do
    it "shows only notes for not logged in user" do
      public_note_list = double(NotesForAllUsers, notes: [])
      expect(NotesForAllUsers).to receive(:perform).once { public_note_list }

      get :index

      expect(assigns[:notes]).not_to be_nil
      expect(assigns[:notes]).to be_decorated
    end
  end
end
