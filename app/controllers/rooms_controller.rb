class RoomsController < ApplicationController

	def create
    public_room = params[:public_room]

    if public_room.blank?
      public_room = false
    end
		r = Room.create(:name => params[:name], :tournament_id => params[:tournament_id], :public_room => public_room)
    UserRoom.create(:room_id => r.id, :user_id => current_user.id)

    if params[:user_ids].present?
      params[:user_ids].each do |user_id|
        UserRoom.create(:room_id => r.id, :user_id => user_id)   
      end
    end
        
    redirect_to room_path(r)
	end

 	def new
  		@tournaments = Tournament.all
  		@users = User.all
  	end
    
  def index
    # -> Room.joins(:invite_users).where('invite_users.uid' => current_user.uid)
      @invited_to_rooms = InviteUser.where(:uid => current_user.uid)

      @user_rooms = Room.joins(:user_rooms).where('user_rooms.user_id' => current_user.id)#.where('invite_users.status' => "accepted")

      for room in @invited_to_rooms
        if(room.status=="accepted")
           @user_rooms.push(room)
        end
      end

      #
      @my_rooms = Room.where(:user_id => current_user.id)

      @public_rooms = Room.where(:public_room => true)
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
        InviteUser.create(room_id: params[:room_id], user_id: user.id, uid: uid, status: "Pending")
      else
        InviteUser.create(room_id: params[:room_id], uid: uid, status: "Pending")
      end
    end
    
     redirect_to :back
  end
end
