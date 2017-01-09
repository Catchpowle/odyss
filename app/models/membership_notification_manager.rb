class MembershipNotificationManager
  def self.notify_users(sender, group)
    group.users.each do |user|
      next if user.eql?(sender)

      notification = Notification.new(sender: sender, notifiable: group)
      user.notifications << notification

      NotificationMailer.new_membership(user, sender, group).deliver_later
    end
  end
end
