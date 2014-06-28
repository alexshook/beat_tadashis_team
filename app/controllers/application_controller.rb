class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_paramaters, if: :devise_controller?

  def configure_permitted_paramaters
    devise_parameter_sanitizer.for(:sign_up) << :name << :goal_description
    devise_parameter_sanitizer.for(:account_update) << :name << :goal_description
  end

end
