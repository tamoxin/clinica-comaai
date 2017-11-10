class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  before_action :require_login, :require_admin, :require_coordinator, :require_professor

  before_action :set_no_cache

  def set_no_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  private

  def require_login
    unless logged_in?
      redirect_to login_path
    end
  end


  def require_admin
    unless admin?
      if coordinator?
        redirect_to users_path
      else if professor?
             redirect_to courses_path
           else if student?
                  redirect_to groups_path
                else
                  redirect_to login_path
                end
           end
      end
    end
  end


  def require_coordinator
    unless coordinator?
      if professor?
             redirect_to courses_path
           else if student?
                  redirect_to groups_path
                else
                  redirect_to login_path
                end
           end
      end
    end


  def require_professor
    unless professor?
      if coordinator?
             redirect_to users_path
           else if student?
                  redirect_to groups_path
                else
                  redirect_to login_path
                end
           end
      end
    end
end



