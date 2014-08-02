class CanAddCommentPolicy
  include Policy::PolicyObject

  def perform
    return fail! unless user
    note = Note.find_by_id note_id
    fail! if note.private? && note.user_id != user.id
  end
end