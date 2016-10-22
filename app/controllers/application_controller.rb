class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  before_filter :set_cache_headers

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
    redirect_to groups_path(sign_in: true)
  end

  def internal_error
    render 'errors/internal_server_error'
  end

  before_filter :set_cache_headers

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
