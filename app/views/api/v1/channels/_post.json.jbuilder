json.extract! post, :id, :link, :channel_id, :created_at, :updated_at
json.read !(post.unread? current_user)

json.description Nokogiri::HTML(post.description).text
json.title Nokogiri::HTML(post.title).text
