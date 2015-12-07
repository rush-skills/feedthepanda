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

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
