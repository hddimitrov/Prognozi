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
    @invited_users = InviteUser.where(room_id: params[:room_id])
  end

  def invite
    params[:uids].split(',').each do |uid|
      user = User.find_by_uid(uid)
    
      if user.present?
        InviteUser.create(room_id: params[:room_id], user_id: user.id, uid: uid)
      else
        InviteUser.create(room_id: params[:room_id], uid: uid)
      end
    end
    
    redirect_to :back
  end
end
