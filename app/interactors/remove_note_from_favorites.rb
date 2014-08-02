class RemoveNoteFromFavorites
  include Interactor

  def perform
    user.favorite_notes.where(note_id: note_id).destroy_all

    context[:message] = "Note has been removed from favorites"
  end
end
