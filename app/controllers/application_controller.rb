class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from StandardError, with: lambda { |e|
    request.local? ? raise(e) : internal_error
  }
  rescue_from ActiveRecord::RecordNotFound, with: :routing_error

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

  def internal_error
    render 'errors/internal_server_error'
  end
end
