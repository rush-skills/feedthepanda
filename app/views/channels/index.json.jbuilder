json.array!(@channels) do |channel|
  json.extract! channel, :id, :name, :description, :image, :post_type, :rss_link, :approved
  json.url channel_url(channel, format: :json)
end
