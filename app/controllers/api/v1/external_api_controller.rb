class API::V1::ExternalAPIController < API::V1::ApplicationController
	before_action :authenticate_channel!, only: [:channel_api]

	def email
		@channel = Channel.friendly.find params[:channel]
		post = Post.new(channel: @channel, title: params[:post_title], description: params[:post_description])
	  if post.save!
      render json: {status: 200, message: "Success"}
    else
      render json: {status: 500, message: "Failed"}
    end

	end

	def channel_api
		@channel = current_channel
		post = Post.new(channel: @channel, title: params[:title], description: params[:description], link: params[:link])
	  if post.save!
      render json: {status: 200, message: "Success"}
    else
      render json: {status: 500, message: "Failed"}
    end
	end
end