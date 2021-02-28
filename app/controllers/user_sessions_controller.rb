class UserSessionsController < ApplicationController
  def new
    session = UserSession.new
  end

  def create
  end
end
