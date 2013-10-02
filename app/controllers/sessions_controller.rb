class SessionsController < ApplicationController
  def oauth_success
    auth = env["omniauth.auth"]
    user = User.find_or_create_by_provider_and_uid(auth.provider, auth.uid)
    user.name = auth.info.name
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user.save!

    session[:user_id] = user.id
    redirect_to root_url
  end

  def oauth_failure
    puts '===================================='
    puts params
    puts '===================================='

    auth = FbGraph::Auth.new('1397561973795270', '3df56d4e9f5ab134fe6f8108311a370a')
    auth.from_signed_request(params[:signed_request])

    auth.exchange_token! auth.access_token

    token = auth.access_token

    puts 'aaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    puts auth
    puts 'aaaaaaaaaaaaaaaaaaaaaaaaaaaa'

    # fb_user = FbGraph::User.me(token).fetch

    puts '00000000000000000000000000000000000000000000'
    # puts fb_user.inspect
    puts '00000000000000000000000000000000000000000000'

    

    render nothing: true
  end

 
end