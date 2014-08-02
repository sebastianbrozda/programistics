class ReturnNoteBySlugAndId
  include Interactor

  def perform
    context[:note] = Note.find_by_id note_id
  end

  private
  def note_id
    id.split(',').last
  end
end
