class User < ActiveRecord::Base
  has_many :identities
  has_many :memberships
  has_many :groups, through: :memberships

  def self.new_with_omniauth(info)
    new(name: info[:name], email: info[:email], image_url: info[:image])
  end

  def can_manage_group?(group)
    membership = memberships.find_by(group: group)

    membership.admin?
  end

  def can_manage_user?(user, group)
    membership = memberships.find_by(group: group)
    return false unless membership && membership.admin?
    return true if user.eql?(self)

    users_membership = user.memberships.find_by(group: group)
    return true unless users_membership.admin?

    membership.admin < users_membership.admin
  end
end
