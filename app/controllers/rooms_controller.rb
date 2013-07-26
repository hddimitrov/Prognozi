class RoomsController < ApplicationController

	def create
		r = Room.create(:name => params[:name], :tournament_id => params[:tournament_id])

    params[:user_ids].each do |user_id|
      ur = UserRoom.new(:room_id => r.id, :user_id => user_id)  
      ur.save    
    end
    
    
    redirect_to room_path(r)
	end

 	def new
  		@tournaments = Tournament.all
  		@users = User.all
  	end
  def index
      @rooms = Room.all
  end

  def show
    @room = Room.find(params[:room_id])
  end
end
