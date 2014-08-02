require 'rails_helper'

RSpec.describe PurchaseController, :type => :controller do

  def set_return_note_by_slug_and_id(note)
    return_note = double(ReturnNoteBySlugAndId)
    expect(return_note).to receive(:note).twice { note }
    expect(ReturnNoteBySlugAndId).to receive(:perform).twice.with({id: note.to_param}) { return_note }
  end

  describe "POST 'note'" do
    context "redirects to log in page when" do

      it "is not logged user" do
        get :note, id: "slug,1"

        expect(response).to redirect_to new_user_session_path
      end

      it "is user with access to note" do
        user = double(User)

        note = double(Note, title: "title", id: 1)

        expect(CanPurchasePolicy).to receive(:perform).
                                         with({user: user, note: note}) {
          double(CanPurchasePolicy, allowed?: false, redirect_to: 'already_purchased', message: '')
        }

        set_return_note_by_slug_and_id note

        sign_in user

        get :note, id: note.to_param

        expect(response).to redirect_to note_path(note)
      end
    end
  end

  describe "GET 'details'" do
    it "show purchase details" do
      user = double(User)
      sign_in user

      note = double(Note, title: "title", id: 1)

      expect(CanPurchasePolicy).to receive(:perform).with({user: user, note: note}) { double(CanPurchasePolicy, allowed?: true) }

      set_return_note_by_slug_and_id note

      button = double(CreateCodebaseButton)
      expect(button).to receive(:html) { 'html' }
      expect(button).to receive(:custom) { 'custom' }
      expect(CreateCodebaseButton).to receive(:perform).with({note_id: note.id, user: user}) { button }

      expect(StartPayment).to receive(:perform).with({note: note, user: user, custom: 'custom'}) { double(StartPayment) }

      get :note, id: note.to_param

      expect(response.status).to eq 200
      expect(assigns[:note]).not_to be nil
      expect(assigns[:button_html]).not_to be_blank

    end
  end

end
