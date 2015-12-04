# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  channel_id :integer
#  approved   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_subscriptions_on_channel_id  (channel_id)
#  index_subscriptions_on_user_id     (user_id)
#

class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel

	scope :approved, -> {where(approved: true)}

  rails_admin do
  	show do
  		field :user
  		field :channel
  		field :approved
  	end
  	list do
  		field :user
  		field :channel
  		field :approved, :toggle
  	end
  	edit do
  		field :user
  		field :channel
  		field :approved
  	end
  end
  def to_s
    self.user.to_s + " - " + self.channel.to_s
  end
end
