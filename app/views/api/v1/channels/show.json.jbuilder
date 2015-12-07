json.channel @channel, partial: 'api/v1/channels/channel', as: :channel
json.posts @posts, partial: 'api/v1/channels/post', as: :post
