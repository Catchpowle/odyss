class NotificationsUser < ActiveRecord::Base
  belongs_to :notification
  belongs_to :user
end
