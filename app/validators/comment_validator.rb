class CommentValidator
  include ActiveModel::Validations

  validates :comment, presence: true, length: {minimum: 5}
  validates :user, presence: true

  def initialize(comment)
    @comment = comment.comment
    @user = comment.user
  end

  private
  attr_reader :comment
  attr_reader :user

end