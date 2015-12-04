# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  provider   :string(255)
#  uid        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role       :integer
#  email      :string(255)
#  avatar     :string(255)
#  gcm_token  :string(255)
#  api_key    :string(255)
#  admin      :boolean
#  superadmin :boolean
#

class User < ActiveRecord::Base
  # enum role: [:user, :vip, :admin]
  after_initialize :init, :if => :new_record?

  has_many :channel_admins
  has_many :subscriptions
  has_many :channels, through: :channel_admin
  has_many :subscribers, through: :subscriptions, source: :channel
  has_many :posts

  def init
    if User.count == 0
      self.admin ||= true
      self.superadmin ||= true
    end
    hex = SecureRandom.hex
    while User.exists?(api_key: hex)
      hex = SecureRandom.hex
    end
    self.api_key = hex
    self.save!
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
         user.avatar = auth['info']['image'] || ""
         # user.name = auth['info']['name'] || ""
      end
    end
  end


  rails_admin do
    show do
      field :name
      field :email
      field :admin
      field :avatar
      field :channels
      field :subscriptions
      field :posts
    end
    list do
      field :name
      field :email
      field :admin
    end
    edit do
      field :name
      field :email
      field :avatar
      field :admin
    end
  end
  def to_s
    self.name
  end
end
