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
        redirect_to login_path, notice: 'Usuario inactivo'
        
      end

    else
      redirect_to login_path, notice: 'Combinación de usuario/contraseña inválido'
    
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end




end
