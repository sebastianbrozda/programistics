class CreateComment
  include Interactor

  def perform
    note = Note.find_by_id note_id
    comment = note.new_comment
    comment.user_id = user_id
    comment.comment = comment_body

    validator = CommentValidator.new comment

    if validator.valid? && comment.save
      note.save

      context[:comment] = comment
      context[:message] = ["Comment has been added"]
    else
      fail!(message: validator.errors.full_messages + comment.errors.full_messages)
    end
  end
end
