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
#

class Channel < ActiveRecord::Base
  has_paper_trail
	has_many :channel_admins
	has_many :subscriptions
	has_many :admins, through: :channel_admins, source: :user
	has_many :subscribers, through: :subscriptions, source: :user
	has_many :posts

	validates_presence_of :name, :description, :post_type

	scope :approved, -> {where(approved: true)}

	extend Enumerize
  enumerize :post_type, in: [:forced,:public,:members], default: :public

  def approved_users
  	self.subscriptions.where(approved: true)
	end
  rails_admin do
    show do
      field :name
      field :description
      field :image
      field :post_type
      field :rss_link
      field :approved
      field :admins
      field :subscribers
      field :posts
    end
    list do
      field :name
      # field :description
      # field :image
      field :post_type
      # field :rss_link
      field :approved
      # field :admins
      # field :subscribers
      # field :posts
    end
    edit do
      field :name
      field :description
      field :image
      # field :post_type
      field :rss_link
      field :approved
      field :admins
      # field :subscribers
      # field :posts
    end
  end

  def to_s
  	self.name
  end
end
