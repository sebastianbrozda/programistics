class CommentDecorator < Draper::Decorator
  delegate_all
  decorates :comment

  def created_at
    object.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  def comment_body
    object.comment.comment
  end
end
