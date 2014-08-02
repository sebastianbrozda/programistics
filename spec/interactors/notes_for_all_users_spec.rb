require 'rails_helper'

describe NotesForAllUsers do

  it 'returs notes for all users' do
    expect(Note).to receive(:for_all_users).and_return([double(Note), double(Note)])
    expect(NotesForAllUsers.perform.notes.size).to eq(2)
  end
end