module Users
  class NotificationsController < ApplicationController
    def index
      @notifications_users = current_user.notifications_users.ordered
    end
  end
end
