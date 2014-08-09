class CommentsController < ApplicationController
  policy(:create_comment, only: :create) { {user: current_user, note_id: note_id} }
  policy(:listing_comment, only: :list) { {user: current_user, note_id: note_id} }

  def create
    create_comment = CreateComment.perform({note_id: note_id, user_id: current_user.id, comment_body: comment_body})
    render json: {msg: create_comment.message, result: create_comment.success?}
  end

  def list
    @comments = GetCommentsForNote.perform({note_id: note_id}).comments
    render partial: "comments/list", locals: {comments: CommentDecorator.decorate_collection(@comments)}
  end

  def unauthorized(message)
    redirect_to root_path
  end

  private
  def note_id
    params[:note_id].to_i
  end

  def comment_body
    params[:comment_body]
  end
end
