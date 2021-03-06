class API::V1::ChannelsController < API::V1::ApplicationController
	before_action :authenticate_user!

	before_action :set_channel, only: [:show, :subscribe, :unsubscribe]

	def feed
		@posts = current_user.feed.with_read_marks_for(current_user)
		# render @posts
	end

	def index
		@channels = Channel.approved
	end

	def show
		if current_user.subscribed @channel and @channel.post_type.members?
			render json: {status: 401, message: "Not Subscribed"}
		end
		@posts = @channel.posts.with_read_marks_for(current_user)
	end

  def mark_read
    @posts  = Post.find(params[:post_ids].gsub(/\[|\]/,'').split(/,/).map(&:to_i))
    @posts.each do |p|
      p.mark_as_read! :for => current_user
    end
    render json: {status: 200, message: "Success"}
  end

	def subscribe
		subs = Subscription.new(user: current_user, channel: @channel)
    if subs.save
      render json: {status: 200, message: "Success"}
    else
      render json: {status: 500, message: "Failed"}
    end
	end

	def unsubscribe
		subs = Subscription.where(user: current_user, channel: @channel)
    if subs.destroy_all
      render json: {status: 200, message: "Success"}
    else
      render json: {status: 500, message: "Failed"}
    end
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.find_by_id(params[:id])
      @channel ||= Channel.friendly.find(params[:id])
    end

end