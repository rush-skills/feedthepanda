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
# Foreign Keys
#
#  fk_rails_5d62c432c0  (user_id => users.id)
#  fk_rails_cd5273bcac  (channel_id => channels.id)
#

class ChannelAdmin < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel

  validates_presence_of :user, :channel

  rails_admin do
  	show do
  		field :user_id
  		field :channel_id
  	end
  	list do
  		field :user_id
  		field :channel_id
  	end
  	edit do
  		field :user_id
  		field :channel_id
  	end
  end

  def to_s
    self.user.to_s + " - " + self.channel.to_s
  end
end
