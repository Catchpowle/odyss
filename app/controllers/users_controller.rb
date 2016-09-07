class UsersController < ApplicationController
  def new
  end

  def create
    response = request.env['omniauth.auth']
    current_user.update(discord_id: response['info']['id'])

    redirect_to root_path
  end
end
