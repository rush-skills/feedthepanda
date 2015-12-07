class API::V1::ApplicationController < ActionController::Base
	respond_to :json
	skip_before_filter :verify_authenticity_token

	helper_method :current_user
	helper_method :authenticate_user!
  helper_method :current_channel
  helper_method :authenticate_channel!

	def current_user
    begin
      @current_user ||= User.find_by_api_key params[:api_key]
    rescue Exception => e
      nil
    end
  end
  def current_channel
    begin
      @current_channel ||= Channel.find_by_api_key params[:api_key]
    rescue Exception => e
      nil
    end
  end
  def authenticate_user!
  	unless current_user
  		# head :unauthorized
  		render json: {status: 401, message: "Unauthorized. Please send api key in params"}
  	end
  end
  def authenticate_channel!
    unless current_channel
      # head :unauthorized
      render json: {status: 401, message: "Unauthorized. Please send api key in params"}
    end
  end
end