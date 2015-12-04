class API::V1::ChannelsController < API::V1::ApplicationController
	before_action :authenticate_user!

	def feed
		@posts = current_user.feed
		render @posts
	end

	def index
		@channels = Channel.approved
	end

	def show
		@channel = Channel.find(params[:id])
		if current_user.subscribed @channel and @channel.post_type.members?
			render json: {status: 401, message: "Not Subscribed"}
		end
		@posts = @channel.posts
	end

	def subscribe
		@channel = Channel.find(params[:id])
		subs = Subscription.new(user: current_user, channel: @channel)
    if subs.save
      render json: {status: 200, message: "Success"}
    else
      render json: {status: 500, message: "Failed"}
    end
	end

	def unsubscribe
		@channel = Channel.find(params[:id])
		subs = Subscription.where(user: current_user, channel: @channel)
    if subs.destroy_all
      render json: {status: 200, message: "Success"}
    else
      render json: {status: 500, message: "Failed"}
    end
	end
end