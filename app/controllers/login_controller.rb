class LoginController < ApplicationController
  skip_before_action :check_session, only: :new

  def new
    if current_user.present?
      redirect_to '/questions' and return
    end
    user_params = filter_user_params
    user = User.find_by(email: user_params[:email])
    if user.nil?
      flash[:notice] = 'Not an existing user ! Please signup'
      redirect_to '/signup'
    else
      session = UserSession.new(user_params)
      if session.save
        redirect_to '/questions' and return
      end
      flash[:notice] = 'Invalid Password !'
      redirect_to '/' and return
    end
  end

  def destroy
    session = UserSession.find
    session.destroy
    redirect_to '/'
  end


  def filter_user_params
    params.require(:user).permit(:email, :password)
  end
end
