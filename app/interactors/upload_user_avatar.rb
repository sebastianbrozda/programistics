class UploadUserAvatar
  include Interactor

  def perform
    user.avatar = file

    if user.save
      context[:user_with_avatar] = user
      context[:message] = "Your avatar has changed"
    else
      fail!message: full_message_error
    end
  end

  def full_message_error
    user.errors.full_messages.join(',')
  end
end
