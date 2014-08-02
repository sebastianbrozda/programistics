require 'rails_helper'

describe RemoveNoteFromFavorites do

  it "removes note from favorites" do
    note_id = 1
    favorite_notes = [double(FavoriteNote), double(FavoriteNote)]
    user = double(User)

    expect(user).to receive(:favorite_notes).once { favorite_notes }
    expect(favorite_notes).to receive(:where).with({note_id: note_id}).once { favorite_notes }
    expect(favorite_notes).to receive(:destroy_all).once

    remove_note = RemoveNoteFromFavorites.perform({user: user, note_id: note_id})

    expect(remove_note.success?).to eq(true)
    expect(remove_note.message).to eq("Note has been removed from favorites")
  end

end