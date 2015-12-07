# == Schema Information
#
# Table name: channels
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  image       :string(255)
#  post_type   :string(255)
#  rss_link    :string(255)
#  approved    :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string(255)
#  api_key     :string(255)
#  description :text(65535)
#
# Indexes
#
#  index_channels_on_api_key  (api_key) UNIQUE
#  index_channels_on_slug     (slug) UNIQUE
#

class Channel < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_paper_trail
  has_many :channel_admins, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :admins, through: :channel_admins, source: :user
  has_many :subscribers, through: :subscriptions, source: :user
  has_many :posts

  validates_presence_of :name, :post_type
  extend Enumerize
  enumerize :post_type, in: [:forced,:public,:members], default: :public

  validates_uniqueness_of :name

  scope :approved, -> {where(approved: true)}
  scope :forced, -> {where(post_type: :forced)}

  after_save :apply_force
  after_create :init

  def apply_force
    if self.post_type.forced?
      users = User.pluck(:id)
      bulk = []
      users.each { |u|
        hash = {}
        hash[:user_id] =  u
        hash[:channel_id] = self.id
        bulk << hash
      }
      Subscription.create(bulk)
    end
  end

  def init
    hex = SecureRandom.hex
    while Channel.exists?(api_key: hex)
      hex = SecureRandom.hex
    end
    self.api_key = hex
    self.save!
  end

  def approved_users
    self.subscriptions.where(approved: true)
  end

  def can_read(user)
    unless self.post_type.forced? or self.post_type.public?
      self.approved_users.exists? user
    else
      true
    end
  end

  def is_admin(user)
    self.admins.exists? user
  end

  rails_admin do
    show do
      field :name
      field :description
      field :image
      field :post_type
      field :rss_link
      # field :api_key
      field :slug
      field :approved
      field :admins
      field :subscribers
      field :posts
    end
    list do
      field :name
      # field :description
      # field :image
      field :slug
      field :post_type
      # field :rss_link
      field :approved, :toggle
      # field :admins
      # field :subscribers
      # field :posts
    end
    edit do
      field :name
      field :description
      field :image
      field :post_type
      field :rss_link
      field :approved
      field :admins
      # field :subscribers
      # field :posts
    end
  end

  # Try building a slug based on the following fields in
  # increasing order of specificity.
  # def slug_candidates
  #   [
  #     :name,
  #     [:name, :post_type],
  #     [:name, :post_type, :created_at],
  #     [:name, :post_type, :description]
  #   ]
  # end

  def to_s
    self.name
  end
end
