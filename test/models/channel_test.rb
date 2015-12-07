# == Schema Information
#
# Table name: channels
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  image       :string(255)
#  post_type   :string(255)
#  rss_link    :string(255)
#  approved    :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string(255)
#
# Indexes
#
#  index_channels_on_slug  (slug) UNIQUE
#

require 'test_helper'

class ChannelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
