require 'rails_helper'

describe ShowAllMyOwnNotes do

  it 'returns all user notes' do
    user = double(User, id: 1)
    notes = (1..3).map { double(Note, user_id: user.id) }
    expect(Note).to receive(:where).with({user_id: user.id}) { notes }

    show_all_my_own_notes = ShowAllMyOwnNotes.perform({user: user})

    expect(show_all_my_own_notes.notes.size).to eq(notes.size)
  end
end