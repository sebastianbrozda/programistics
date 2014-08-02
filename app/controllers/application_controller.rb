class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Policy::PolicyBehaviour

  before_filter :configure_permitted_parameters, if: :devise_controller?

  before_filter :load_js_config

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :user_name
  end

  def load_js_config
    @note_type_paid_access = NoteType::TYPE_PAID_ACCESS
  end
end
