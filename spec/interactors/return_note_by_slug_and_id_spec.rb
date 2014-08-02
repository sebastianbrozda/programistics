require 'rails_helper'

describe ReturnNoteBySlugAndId do
  it "returns note" do
    expect(Note).to receive(:find_by_id).with('1').and_return(double(Note))

    show_note = ReturnNoteBySlugAndId.perform({id: 'title-1,1'})

    expect(show_note.note).not_to be_nil
  end
end