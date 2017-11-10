class SessionsController < ApplicationController

  skip_before_action :require_login, :require_admin, :require_coordinator, :require_professor
  before_action :require_login, only: [:destroy]
  before_action :not_logged, only: [:new, :create]


  def not_logged
    if logged_in?
      redirect_to root_path
    end
  end


  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.password == (params[:session][:password])
      if user.active?
        log_in user
        redirect_to root_path
      else
        flash[:danger] = 'Inactive user'
        render 'new'
      end

    else
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end




end
