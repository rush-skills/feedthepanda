json.extract! channel, :id, :image, :post_type, :rss_link, :approved, :created_at, :updated_at
json.subscribed current_user.subscribed(channel)
json.description Nokogiri::HTML(channel.description).text
json.name Nokogiri::HTML(channel.name).text
