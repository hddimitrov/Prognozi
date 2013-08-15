class UsersController < ApplicationController

  def index
    @userrooms = UserRoom.all
  	@users = User.all
  end
end
