class NotificationsUsersController < ApplicationController
  def update
    current_user.notifications_users.update_all(notifications_user_params)
    render nothing: true
  end

  private

  def notifications_user_params
    params.require(:notifications_user).permit(:read)
  end
end
