class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_tournament

  def current_tournament
    @current_tournament = Tournament.find $current_tournament
  end
end
