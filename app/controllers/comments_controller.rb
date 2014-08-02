class CommentsController < ApplicationController
  def create
    create_comment = CreateComment.perform({note_id: note_id, user_id: current_user.id, comment_body: comment_body})
    render json: {msg: create_comment.message, result: create_comment.success?}
  end

  private
  def note_id
    params[:note_id].to_i
  end

  def comment_body
    params[:comment_body]
  end
end
