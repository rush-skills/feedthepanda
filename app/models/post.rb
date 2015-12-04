# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :string(255)
#  link        :string(255)
#  user_id     :integer
#  channel_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_posts_on_channel_id  (channel_id)
#  index_posts_on_user_id     (user_id)
#

class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel

  validates_presence_of :title, :description, :channel

  rails_admin do
    show do
      field :title
      field :description
      field :link
      field :channel
      field :user
    end
    list do
      field :title
      # field :description
      # field :link
      field :channel
      field :user
    end
    edit do
      field :title
      field :description
      field :link
      field :channel
      # field :user
    end
  end
  def to_s
    self.title
  end
end
