class ApplicationController < ActionController::Base
  protect_from_forgery

  #  private

  #  def current_user
  #   # @current_user ||= User.find(session[:user_id]) if session[:user_id]
  #   @current_user = User.last
  #  end

  #  helper_method :current_user

  def current_tournament
    @current_tournament = Tournament.find_by_name('2014 FIFA World Cup')
  end

  helper_method :current_tournament
end

  # has_many :user_rooms
  # has_many :score_predictions
  # has_many :user_bets
