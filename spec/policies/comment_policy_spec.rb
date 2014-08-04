require 'rails_helper'

describe CommentPolicy do

  it 'fails when user is not logged in' do
    can = CommentPolicy.perform({user: nil})

    expect(can.allowed?).to be false
  end

  it 'fails when user wants to comment someones private note' do
    note = double(Note, id: 1, private?: true, user_id: 123)
    expect(Note).to receive(:find_by_id).with(note.id) { note }

    can = CommentPolicy.perform({user: double(User, id: 1), note_id: note.id})

    expect(can.allowed?).to be false
  end
end