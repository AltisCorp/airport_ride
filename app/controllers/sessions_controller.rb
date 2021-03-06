class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    user.update_attribute(:access_token, auth["credentials"]["token"])
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Logged in"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out"
  end
  
end
