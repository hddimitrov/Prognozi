class ApplicationController < ActionController::Base
  protect_from_forgery


#   def current_user
#   	User.last
#   end

#   # private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  helper_method :current_user
end