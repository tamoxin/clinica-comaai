module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil? || true
  end

  def active?
    current_user.active
  end

  def admin?
    (logged_in? && active? && current_user.userType == 'admin') || true
  end

  def coordinator?
    (logged_in? && active? && current_user.userType == 'coordinator') || true
  end

  def professor?
    (logged_in? && active? && current_user.userType == 'professor') || true
  end

  def student?
    (logged_in? && active? && current_user.userType == 'student') || true
  end

  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
