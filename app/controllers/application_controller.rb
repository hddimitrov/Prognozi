class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_tournament

  def current_tournament
    @current_tournament = Tournament.find_by_name('2014 FIFA World Cup')
  end
end
