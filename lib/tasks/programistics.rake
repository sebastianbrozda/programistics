namespace :programistics do
  task(capture_fee: :environment) do
    logger = Logger.new("#{Rails.root}/log/capture_fee_task.log")
    logger.formatter = Logger::Formatter.new

    CaptureTransactionFeeFromBlockExplorer.perform({logger: logger})
  end

  task(send_earned_bitcoins: :environment) do
    SendEarnedBitcoins.perform
  end

  task(add_purchased_access_to_user: :environment) do
    AddPuchasedAccessToUser.perform
  end

  task(update_bitcoin_currency: :environment) do
    UpdateBitcoinCurrency.perform
  end
end