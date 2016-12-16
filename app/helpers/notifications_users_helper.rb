module NotificationsUsersHelper
  def notification_link(notifications_user)
    status = notifications_user.read? ? 'read' : 'unread'
    notification = notifications_user.notification
    partial_location = "users/notifications/#{notification.notifiable_type.downcase}"
    render partial_location, notification: notification, status: status
  end
end
