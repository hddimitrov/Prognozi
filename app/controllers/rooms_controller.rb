class RoomsController < ApplicationController

	def create
		r = Room.new(:name => params[:name], :tournament_id => params[:tournament_id])
    r.save
    redirect_to action: 'index'
	end

 	def new
  		@tournaments = Tournament.all
  		@users = User.all
  	end

  def index
    @rooms = Room.all
  end
end
