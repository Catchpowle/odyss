class SessionsController < ApplicationController
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

    if current_user.slack_id
      redirect_to root_path, notice: 'Already signed in!'
    else
      redirect_to new_user_path
    end
  end

  def existing_identity_sign_in
    self.current_user = @identity.user

    if current_user.slack_id
      redirect_to root_url, notice: 'Signed in!'
    else
      redirect_to new_user_path
    end
  end

  def new_identity_sign_in(info)
    user = User.find_by(email: info[:email])
    user = User.new_with_omniauth(info) if user.nil?

    Slack.new(ENV['SLACK_TOKEN']).invite(user.email)

    user.identities << @identity
    user.save

    self.current_user = user

    redirect_to new_user_path
  end
end
