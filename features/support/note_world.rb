module NoteWorld

  def fill_note_creation_form opts
    fill_in :note_title, with: "Note title"
    fill_in :note_short_body, with: "Short body"
    fill_in :note_body, with: "Note body"
    fill_in :tags_, with: "ruby,rails"
    select(opts[:note_type], :from => :note_note_type_id)
  end

end

World(NoteWorld)