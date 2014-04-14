class ApplicationController < ActionController::Base
  protect_from_forgery


#   def current_user
#   	User.last
#   end

#   # private

  def current_user
    # @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_user = User.last
  end

   def current_tournament
    # @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_tournament = Tournament.find_by_name('2014 FIFA World Cup')
  end

  helper_method :current_user
  helper_method :current_tournament
end
