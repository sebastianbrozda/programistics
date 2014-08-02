require 'rails_helper'

describe CreateNote do

  it "creates note with valid attributes" do
    note = Note.new
    expect(note).to receive(:save).once.and_return(true)
    expect(Note).to receive(:new).once.and_return(note)

    user = User.new id: 1
    create_note = CreateNote.perform({note_params: {}, user: user, tags: "ruby,rails"})

    expect(create_note.success?).to eq(true)
    expect(create_note.note.user).to eq(user)
    expect(create_note.note.tag_list.size).to eq(2)
  end

  it "shows message error with invalid attributes" do
    note = Note.new
    expect(note).to receive(:save).once.and_return(false)
    expect(Note).to receive(:new).and_return(note)

    create_note = CreateNote.perform({note_params: {}, user: nil, tags: []})

    expect(create_note.success?).to eq(false)
  end

end