class UsersController < ApplicationController
  def new
  end

  def create
    response = request.env['omniauth.auth']
    current_user.update(discord_id: response['info']['id'])
    track_create

    redirect_to root_path, notice: 'Signed in!'
  end

  def track_create
    @analytics.track(['discord_synced'])
  end
end
