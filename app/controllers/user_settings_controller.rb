class UserSettingsController < ApplicationController
  policy(:has_login, except: [:show, :purchase]) { {user: current_user} }

  def index
  end

  def unauthorized(message)
    redirect_to new_user_session_path, alert: message
  end

  def update_email
    update = UpdateUserEmail.perform({user: current_user, email: params[:email]})
    render json: {result: update.success?, msg: update.message}
  end

  def update_bitcoin_wallet
    update = UpdateUserBitcoinWallet.perform({user: current_user, wallet: params[:wallet]})
    render json: {result: update.success?, msg: update.message}
  end

  def upload_avatar
    upload = UploadUserAvatar.perform({user: current_user, file: params[:file]})
    message = upload.success? ? {notice: upload.message} : {alert: upload.message}
    redirect_to user_settings_path, message
  end
end