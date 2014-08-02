class CreateComment
  include Interactor

  def perform
    note = Note.find_by_id note_id
    comment = note.create_comment
    comment.user_id = user_id
    comment.comment = comment_body

    validator = CommentValidator.new comment

    if validator.valid? && comment.save
      context[:comment] = comment
      context[:message] = ["Comment has been added"]
    else
      fail!(message: validator.errors + comment.errors)
    end
  end
end
