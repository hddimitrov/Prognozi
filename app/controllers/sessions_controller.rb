class SessionsController < ApplicationController
  def create
    user = FbUser.from_omniauth(env["omniauth.auth"])
    session[:fbuser_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:fbuser_id] = nil
    redirect_to root_url
  end

 
end