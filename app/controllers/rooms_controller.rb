class RoomsController < ApplicationController

	def create

		r = Room.create(:name => params[:name])
    r.q_public = params[:q_public].present?
    r.tournament_id = current_tournament
    r.creator_id = current_user.id
    r.save

    UserRoom.create(room_id: r.id, user_id: current_user.id)

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
      @users = User.all
      #test
        #@matches = Match.all
      #test

      #ranklist TEST

      @predictions = MatchPrediction.all
      @matchesCL = Match.where('start_at > ?', Time.now).order(:start_at).reverse_order

      @invited_to_rooms = Room.joins(:invitations).where('invitations.uid' => current_user.uid)
                                                   .where('invitations.status' => 'pending')
                                                   .select('invitations.status, rooms.*')

      @user_rooms = Room.joins(:user_rooms).where('user_rooms.user_id' => current_user.id)

      @my_rooms = Room.where(user_id: current_user.id)

      @public_rooms = Room.where(q_public: true)
      @rooms = Room.all
  end

  def show
    @room = Room.find(params[:room_id])
    @invited_users = Invitation.where(room_id: params[:room_id])

    # @rankings = ScorePredictionRoomPoint.joins(:score_prediction).where(:room_id => @room.id).select("user_id, room_id, sum(points) points").group("user_id, room_id").order(:points).reverse_order
    # @users = User.all


  end

  def invite
    params[:uids].split(',').each do |uid|
      user = User.find_by_uid(uid)

      if user.present?
        Invitation.create(room_id: params[:room_id], user_id: user.id, uid: uid, status: "pending")
      else
        Invitation.create(room_id: params[:room_id], uid: uid, status: "pending")
      end
    end

     redirect_to :back
  end

  def room_inv_accept
    @room = Room.find(params[:room_id])
    Invitation.update_all("status = 'accepted'","room_id = #{@room.id} and uid = #{current_user.uid}" ) # @invitations.where(:room_id => @room.id).where(:uid => current_user.uid)
    UserRoom.create(room_id: params[:room_id], user_id: current_user.id)
    render json: {room_id: @room.id, room_name: @room.name}
  end

  def room_inv_decline
    @room = Room.find(params[:room_id])
    Invitation.update_all("status = 'declined'","room_id = #{@room.id} and uid = #{current_user.uid}" )  # @invitations.where(:room_id => @room.id).where(:uid => current_user.uid)
    render nothing: true

  end
end
