require 'rails_helper'

describe CreateCommentPolicy do

  it 'fails when user is not logged in' do
    policy = CreateCommentPolicy.perform({user: nil})

    expect(policy.allowed?).to be false
  end

  it 'fails when user wants to comment someones private note' do
    note = double(Note, id: 1, private?: true, user_id: 123)
    expect(Note).to receive(:find_by_id).with(note.id) { note }

    policy = CreateCommentPolicy.perform({user: double(User, id: 1), note_id: note.id})

    expect(policy.allowed?).to be false
  end
end