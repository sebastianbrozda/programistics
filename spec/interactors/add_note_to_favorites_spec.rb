require 'rails_helper'

describe AddNoteToFavorites do

  it "adds note to favorites" do
    user = User.new id: 1
    expect(user).to receive(:save).once { true }

    note = Note.new id: 1
    expect(Note).to receive(:find_by_id).with(note.id).once { note }

    add_note_to_favorites = AddNoteToFavorites.perform({user: user, note_id: note.id})

    expect(add_note_to_favorites.success?).to be true
    expect(add_note_to_favorites.message).not_to be_nil
    expect(user.favorites.size).to eq(1)
  end

  it "don't add private note to favorites" do
    user = User.new id: 1

    private_note = Note.new id: 1, user_id: 2, note_type_id: NoteType::TYPE_PRIVATE
    expect(Note).to receive(:find_by_id).with(private_note.id).once { private_note }

    add_note_to_favorites = AddNoteToFavorites.perform({user: user, note_id: private_note.id})

    expect(add_note_to_favorites.success?).to be false
    expect(add_note_to_favorites.message).not_to be_nil
    expect(user.favorites).to be_empty
  end

end