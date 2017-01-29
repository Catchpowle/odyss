class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  before_action :set_cache_headers
  before_action :set_raven_context
  around_action :set_analytics_cookie

  rescue_from StandardError, with: lambda { |e|
    request.local? ? raise(e) : internal_error
  }
  rescue_from ActiveRecord::RecordNotFound, with: lambda { |e|
    request.local? ? raise(e) : routing_error
  }
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def routing_error
    render 'errors/not_found', status: :not_found
  end

  private

  helper_method :current_user, :signed_in?

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? nil : user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    !current_user.nil?
  end

  def user_not_authorized
    if current_user
      flash[:error] = 'Please link your account with Discord to continue.'
      redirect_to new_user_path
    else
      cookies[:unauthorized] = true
      redirect_to groups_path
    end
  end

  def internal_error
    render 'errors/internal_server_error'
  end

  def set_analytics_cookie
    @analytics = AnalyticsManager.new

    yield

    @analytics.identify(current_user.id) if current_user

    cookies[:analytics] = set_cookies
  end

  def set_raven_context
    return unless current_user

    Raven.user_context(id: current_user.id, email: current_user.email)
  end

  def set_cache_headers
    response.headers['Cache-Control'] = 'no-cache, no-store'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
  end

  def set_cookies
    if cookies[:analytics]
      cookie = JSON.parse(cookies[:analytics])
      (cookie << @analytics.events).to_json
    else
      [@analytics.events].to_json
    end
  end
end
