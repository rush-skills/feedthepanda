# == Schema Information
#
# Table name: channel_admins
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  channel_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_channel_admins_on_channel_id  (channel_id)
#  index_channel_admins_on_user_id     (user_id)
#

class ChannelAdmin < ActiveRecord::Base
  has_paper_trail
  belongs_to :user
  belongs_to :channel

  validates_presence_of :user, :channel

  rails_admin do
  	show do
  		field :user
  		field :channel
  	end
  	list do
  		field :user
  		field :channel
  	end
  	edit do
  		field :user
  		field :channel
  	end
  end

  def to_s
    self.user.to_s + " - " + self.channel.to_s
  end
end
