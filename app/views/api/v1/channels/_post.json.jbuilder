json.extract! post, :id, :title, :description, :link, :channel_id, :created_at, :updated_at
json.read !(post.unread? current_user)
