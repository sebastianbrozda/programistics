require 'rails_helper'

describe GetCommentsForNote do

  it 'returns comments for note' do
    note_id = 1
    expect(Note).to receive(:find_by_id).with(note_id) do
      double(Note, comments: [double(Comment), double(Comment)])
    end

    comments = GetCommentsForNote.perform({note_id: note_id}).comments
    expect(comments.size).to eq 2
  end
end