class UsersController < ApplicationController

  def index
    @userrooms = UserRoom.all
  	@users = User.all
  end

  def fb_login
    @domain = 'localhost:3000'
    render :layout => false
  end

  def fb_js_auth
    auth = FbGraph::Auth.new(FB_APP_ID, FB_APP_SECRET)
    auth.from_signed_request(params[:signed_request])

    auth.exchange_token! auth.access_token

    token = auth.access_token

    fb_user = FbGraph::User.me(token).fetch

    puts '=============================================='
    puts fb_user.inspect
    puts '=============================================='

    render nothing: true
  end
end
