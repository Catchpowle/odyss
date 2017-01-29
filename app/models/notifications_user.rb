class NotificationsUser < ActiveRecord::Base
  belongs_to :notification
  belongs_to :user

  scope :ordered, -> { includes(notification: [:notifiable, :sender]).order(:read) }
end
