class SessionsController < ApplicationController

  def new
    redirect_to '/auth/google_oauth2'
  end

  def create
    auth = request.env["omniauth.auth"]
    reset_session
    # unless auth['info']['email'].split('@').last == "iiitd.ac.in"
    #   redirect_to root_url, :error => "Only for IIITD Emails"
    #   Rails.logger.warn "Non IIITD access from "+ auth['info']['email'].to_s
    # end
    user = User.where("provider = ? AND uid = ? OR email = ?", auth['provider'], auth['uid'].to_s, auth['info']['email'].to_s).first || User.create_with_omniauth(auth)
    reset_session
    session[:user_id] = user.id
    redirect_to root_url, :notice => 'Signed in!'
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
