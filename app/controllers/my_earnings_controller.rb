class MyEarningsController < ApplicationController
  policy(:has_login) { {user: current_user} }

  def index
    earning_list = MyEarningList.perform({user: current_user})
    @payments = earning_list.payments
    @summary = earning_list.summary
  end

  def unauthorized(message)
    redirect_to new_user_session_path, alert: message
  end
end
