class CreateNote
  include Interactor

  def perform
    note = Note.new note_params
    note.user = user
    note.tag_list = tags

    context[:note] = note
    unless note.save
      fail!
    end
  end
end
