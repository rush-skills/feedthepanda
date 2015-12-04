json.extract! channel, :id, :name, :description, :image, :post_type, :rss_link, :approved, :created_at, :updated_at
json.subscribed current_user.subscribed(channel)
