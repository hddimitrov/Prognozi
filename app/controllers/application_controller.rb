class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_tournament

  def current_tournament
    @current_tournament = Tournament.find $current_tournament
  end

  before_filter :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:name, :referer_name, :email, :password, :password_confirmation)
    end
  end

end
