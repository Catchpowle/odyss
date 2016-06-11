class UsersController < ApplicationController
  def new
  end

  def create
    response = request.env['omniauth.auth']
    slack_id = response['info']['user_id']
    slack_token = response['credentials']['token']
    current_user.update(slack_id: slack_id, slack_token: slack_token)

    redirect_to root_path
  end
end
