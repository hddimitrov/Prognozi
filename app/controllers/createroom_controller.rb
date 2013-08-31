class CreateroomController < ApplicationController

	def create
		Room.new(:name => params[:name], :tournamen_id => params[:tournamen_id])
	end

 	def index
  	@tournaments = Tournament.all
  	@users = User.all
  end
end
