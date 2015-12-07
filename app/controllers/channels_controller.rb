class ChannelsController < ApplicationController
  before_action :set_channel, only: [:show, :subscribe, :unsubscribe]
  before_action :authenticate_user!

  # GET /channels
  # GET /channels.json
  def index
    @channels = Channel.approved
  end

  # GET /channels/1
  # GET /channels/1.json
  def show
    @posts = @channel.posts.with_read_marks_for(current_user)
  end

  def feed
    @posts = current_user.sorted_feed.with_read_marks_for(current_user)
  end

  # GET /channels/new
  def new
    @channel = Channel.new
  end

  def subscribe
    subs = Subscription.new(user: current_user, channel: @channel)
    if subs.save
      redirect_to channels_path, flash: { message: "Success"}
    else
      redirect_to channels_path, flash: { message: "Failed"}
    end
  end

  def unsubscribe
    subs = Subscription.where(user: current_user, channel: @channel)
    if subs.destroy_all
      redirect_to channels_path, flash: { message: "Success"}
    else
      redirect_to channels_path, flash: { message: "Failed"}
    end
  end

  # GET /channels/1/edit
  def edit
  end

  # POST /channels
  # POST /channels.json
  def create
    @channel = Channel.new(channel_params)

    respond_to do |format|
      if @channel.save
        format.html { redirect_to @channel, notice: 'Channel was successfully created.' }
        format.json { render :show, status: :created, location: @channel }
      else
        format.html { render :new }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.find_by_id(params[:id])
      @channel ||= Channel.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def channel_params
      params.require(:channel).permit(:name, :description, :image, :post_type, :rss_link, :approved)
    end
end
