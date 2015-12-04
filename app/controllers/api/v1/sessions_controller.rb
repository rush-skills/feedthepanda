class API::V1::SessionsController < API::V1::ApplicationController


  def login
    token = params[:token]
    email_uid_response = HTTParty.get("https://www.googleapis.com/oauth2/v3/tokeninfo?access_token=" + token)
    name_response = HTTParty.get("https://www.googleapis.com/oauth2/v1/userinfo?access_token=" + token)

    uid = email_uid_response["sub"]
    email = email_uid_response["email"]
    name = name_response["name"]

    user = User.where("provider = ? AND uid = ? OR email = ?", "google_oauth2", uid, email).first_or_create! do |user|
      user.email = email
      user.uid = uid
      user.name = name
      user.provider = "google_oauth2"
    end

    if user
      render json: {status: 200, message: "Success", api_key: user.api_key}
    else
      render json: {status: 500, message: "Failed"}
    end
  end

  def emaillogin
    email = params[:email]
    name = params[:name]
    # email_uid_response = HTTParty.get("https://www.googleapis.com/oauth2/v3/tokeninfo?access_token=" + token)
    # name_response = HTTParty.get("https://www.googleapis.com/oauth2/v1/userinfo?access_token=" + token)

    # uid = email_uid_response["sub"]
    # email = email_uid_response["email"]
    # name = name_response["name"]

    user = User.where(email: email).first_or_create! do |user|
      user.email = email
      # user.uid = uid
      user.name = name
      user.provider = "google_oauth2"
    end

    if user
      render json: {status: 200, message: "Success", api_key: user.api_key}
    else
      render json: {status: 500, message: "Failed"}
    end
  end


	def logged_in
		if current_user
			render json: {status: true}
		else
			render json: {status: false}
		end
	end

	def register_gcm
    u = current_user
    u.gcm_token = params[:gcm_token]
    if u.save
      render json: {status: 200, message: "Success", api_key: u.api_key}
    else
      render json: {status: 500, message: "Failed"}
    end
  end
end