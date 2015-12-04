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

require 'test_helper'

class ChannelAdminTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
