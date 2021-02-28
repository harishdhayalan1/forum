class HomeController < ApplicationController
  skip_before_action :check_session

  def index
    if current_user.present?
      redirect_to '/questions' and return
    end
    @user = User.new
  end
end
