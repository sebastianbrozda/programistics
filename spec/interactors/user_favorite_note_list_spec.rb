require 'rails_helper'

describe 'UserFavoriteNoteList' do
  it "gets user favorite notes" do
    user_id = 1
    user = double(Note, id: user_id)
    expect(user).to receive(:author?).with(1) { false }
    expect(user).to receive(:author?).with(2) { true }

    favorite_notes = [
        Note.new(id: 1, user_id: 100, note_type_id: NoteType::TYPE_PRIVATE),
        Note.new(id: 2, user_id: user_id, note_type_id: NoteType::TYPE_PRIVATE),
        Note.new(id: 3, user_id: user_id, note_type_id: NoteType::TYPE_PUBLIC),
        Note.new(id: 4, user_id: user_id, note_type_id: NoteType::TYPE_PAID_ACCESS)
    ]

    expect(user).to receive(:favorites) { favorite_notes }

    user_fav_note_list = UserFavoriteNoteList.perform({user: user})

    expect(user_fav_note_list.notes.size).to eq(3)
  end
end
