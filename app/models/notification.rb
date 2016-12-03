class Notification < ActiveRecord::Base
  has_many :notifications_users
  has_many :users, through: :notifications_users
  belongs_to :notifiable, polymorphic: true
  belongs_to :sender, class_name: :User
end
