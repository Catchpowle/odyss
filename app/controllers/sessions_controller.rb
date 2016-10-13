class SessionsController < ApplicationController
  include CurrentUserInvite

  def create
    auth = request.env['omniauth.auth']
    @identity = Identity.find_or_create_by(uid: auth[:uid],
                                           provider: auth[:provider])
    if signed_in?
      current_user_sign_in
    elsif @identity.user.present?
      existing_identity_sign_in
    else
      new_identity_sign_in(auth[:info])
    end
  end

  def destroy
    self.current_user = nil
    redirect_to root_url, notice: 'Signed out!'
  end

  def auth_failure
    redirect_to root_path
  end

  private

  def current_user_sign_in
    unless @identity.user.eql?(current_user)
      @identity.user = current_user
      @identity.save
    end

    if current_user.discord_id
      redirect_to root_path, notice: 'Already signed in!'
    else
      redirect_to new_user_path
    end
  end

  def existing_identity_sign_in
    self.current_user = @identity.user

    redirect
  end

  def new_identity_sign_in(info)
    user = User.find_by(email: info[:email])

    user ? existing_user_sign_in(user) : new_user_sign_in(info)
  end

  def existing_user_sign_in(user)
    user_set_up(user)

    redirect
  end

  def new_user_sign_in(info)
    user = User.new_with_omniauth(info)
    user_set_up(user)

    redirect
  end

  def user_set_up(user)
    user.identities << @identity
    user.save
    self.current_user = user
  end

  def redirect
    if cookies[:group_id]
      group = Group.find_by(cookies[:group_id])
      cookies.delete(:group_id)
      current_user_invite(group)
    elsif current_user.discord_id
      redirect_to root_url, notice: 'Signed in!'
    else
      redirect_to new_user_path
    end
  end
end
