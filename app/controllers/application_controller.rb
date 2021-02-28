class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :check_session

  def check_session
    session = UserSession.find
    if session.blank?
      flash[:notice] = "Please Login first!"
      redirect_to '/' and return
    end
    @current_session = session
    @current_user = session.user
  end

  def record_not_found
    render file: "/public/404.html", layout: false
  end

  def current_session
    @current_session
  end

  def current_user
    @current_user
  end

end
