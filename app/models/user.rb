class User < ActiveRecord::Base
  has_many :identities

  def self.new_with_omniauth(info)
    new(name: info[:name], email: info[:email], image_url: info[:image])
  end
end
