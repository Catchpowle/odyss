class User < ActiveRecord::Base
  has_many :identities
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :notifications_users
  has_many :notifications, through: :notifications_users

  def self.new_with_omniauth(info)
    new(name: info[:name], email: info[:email], image_url: info[:image])
  end

  def first_name
    name.split[0]
  end

  def last_name
    name.split[1]
  end

  def can_manage_group?(group)
    membership = memberships.find_by(group: group)

    membership && membership.admin?
  end

  def can_manage_user?(user, group)
    membership = memberships.find_by(group: group)
    return false unless membership && membership.admin?
    return true if user.eql?(self)

    users_membership = user.memberships.find_by(group: group)
    return true unless users_membership.admin?

    membership.admin < users_membership.admin
  end

  def unread_notifications?
    notifications_users.where(read: false).present?
  end

  def unread_notifications_count
    notifications_users.where(read: false).count
  end
end
