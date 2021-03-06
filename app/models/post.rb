# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  link        :string(255)
#  user_id     :integer
#  channel_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text(65535)
#
# Indexes
#
#  index_posts_on_channel_id  (channel_id)
#  index_posts_on_user_id     (user_id)
#

class Post < ActiveRecord::Base
  acts_as_readable :on => :created_at

  has_paper_trail
  belongs_to :user
  belongs_to :channel

  validates_presence_of :title, :description, :channel

  def can_read(user)
    self.channel.can_read user
  end

  validates_uniqueness_of :title, scope: :channel

  after_create do |notification|
    require 'gcm'

    tokens = notification.channel.subscribers.where.not(gcm_token: nil).pluck(:gcm_token)

    gcm = GCM.new(ENV["GCM_KEY"])
    options = {data: {title: notification.channel.to_s, message: notification.title}}
    response = gcm.send(tokens,options)
    Rails.logger.warn ("GCM Sent, Response: " + response.to_s)
  end

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
