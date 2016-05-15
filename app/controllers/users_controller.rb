class UsersController < ApplicationController
  def new
  end

  def create
    slack_id = request.env['omniauth.auth']['info']['user_id']
    current_user.update(slack_id: slack_id)

    redirect_to root_path
  end
end
