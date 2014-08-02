class AddNoteToFavorites
  include Interactor

  def perform
    note = Note.find_by_id note_id

    if note.private?
      fail! message: "This note is private"
      return
    end

    user.favorites << note

    if user.save
      context[:message] = "Note has been added to favorites"
    end

  end
end
