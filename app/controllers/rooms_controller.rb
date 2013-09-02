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
      #test
        #@matches = Match.all
      #test

      #ranklist TEST

      @predictions = ScorePrediction.all
      @matches = Match.all

      #ranklist TEST




    # -> Room.joins(:invite_users).where('invite_users.uid' => current_user.uid)
      user = User.last # current_user.uid
      @invited_to_rooms = Room.joins(:invite_users)
      .where('invite_users.uid' => user.uid) 
      .where('invite_users.status' => "Pending")
      .select('invite_users.status, rooms.*')

      @user_rooms = Room.joins(:user_rooms).where('user_rooms.user_id' => user.id)

      #
      @my_rooms = Room.where(:user_id => user.id)

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

  def room_inv_accept
    @room = Room.find(params[:room_id])
    InviteUser.update_all("status = 'Accepted'","room_id = #{@room.id} and uid = #{current_user.uid}" ) # @invitations.where(:room_id => @room.id).where(:uid => current_user.uid) 
    UserRoom.create(room_id: params[:room_id], user_id: current_user.id, uid: current_user.uid)
    render json: {room_id: @room.id, room_name: @room.name}
  end

  def room_inv_decline
    @room = Room.find(params[:room_id])
    InviteUser.update_all("status = 'Declined'","room_id = #{@room.id} and uid = #{current_user.uid}" )  # @invitations.where(:room_id => @room.id).where(:uid => current_user.uid) 
    render nothing: true

  end
end
