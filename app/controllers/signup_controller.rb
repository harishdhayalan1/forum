class SignupController < ApplicationController
  skip_before_action :check_session

  def index
  end

  def new
    if current_user.present?
      redirect_to '/questions' and return
    end
    user_params = filter_user_params
    if User.find_by(email: user_params[:email])
      flash[:notice] = 'Email already exists ! Please login'
      redirect_to '/login'
    else
      user = User.new(user_params)
      user.active = true
      if user.save
        UserSession.create!(user)
        redirect_to '/questions'
      else
        flash[:notice] = user.errors.full_messages
        redirect_to '/signup'
      end
    end
  end


  def filter_user_params
    params.require(:user).permit(:email, :password, :name, :password_confirmation)
  end

end
