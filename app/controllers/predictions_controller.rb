class PredictionsController < ApplicationController

  def predict
    @tournament = Tournament.find(params[:tournament_id])
    @matches = Match.where(:tournament_id => @tournament.id)
  end

end