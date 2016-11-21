module Users
  class NotificationsController < ApplicationController
    def index
      @notifications = PublicActivity::Activity.order('created_at DESC')
    end
  end
end
