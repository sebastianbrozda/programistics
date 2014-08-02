module ControllerHelpers
  def sign_in(user = double(User))
    if user
      allow(env_warden).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    else
      allow(env_warden).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
      allow(controller).to receive(:current_user).and_return(nil)
    end
  end

  def sign_out
    allow(env_warden).to receive(:authenticate!).and_return(nil)
    allow(controller).to receive(:current_user).and_return(nil)
  end

  private
  def env_warden
    request.env['warden']
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.include ControllerHelpers, :type => :controller
end