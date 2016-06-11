class User < ActiveRecord::Base
  has_many :identities
  has_many :memberships
  has_many :groups, through: :memberships

  def self.new_with_omniauth(info)
    new(name: info[:name], email: info[:email], image_url: info[:image])
  end
end
