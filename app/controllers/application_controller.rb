class ApplicationController < ActionController::Base
  protect_from_forgery
  private

 def current_fbuser
  @current_fbuser ||= FbUser.find(session[:fbuser_id]) if session[:fbuser_id]
end
helper_method :current_fbuser
end

