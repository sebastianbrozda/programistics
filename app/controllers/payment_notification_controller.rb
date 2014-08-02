class PaymentNotificationController < ApplicationController

  def coinbase
    process_callback = ProcessCoinbaseCallback.perform({order: params[:order]})

    if process_callback.success?
      render text: "ok"
    else
      error_msg = get_error_msg(process_callback)
      logger.error error_msg
      render text: error_msg, status: 500
    end
  end

  private
  def get_error_msg(process_callback)
    process_callback.errors.join("#")
  end

end
