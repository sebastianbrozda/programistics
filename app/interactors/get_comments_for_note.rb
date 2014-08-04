class GetCommentsForNote
  include Interactor

  def perform
    note = Note.find_by_id note_id
    context[:comments] = note.comments
  end
end
