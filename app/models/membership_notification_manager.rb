class MembershipNotificationManager
  def self.notify_users(sender, group)
    group.users.each do |user|
      next if user.eql?(sender)

      notification = Notification.new(sender: sender, notifiable: group)
      user.notifications << notification
    end
  end
end
