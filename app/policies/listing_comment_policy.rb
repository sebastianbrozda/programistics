class ListingCommentPolicy
  include Policy::PolicyObject

  def perform
    note = Note.find_by_id note_id
    if note.private?
      return fail! if !user || !user.author?(note.id)
    end
  end
end