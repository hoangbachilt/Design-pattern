module SessionsHelper
  def current_user
    if user_id = session[:user_id]
      @current_user || User.find_by(id: user_id)
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by id: user_id
      if user&.authenticated?(:remember, cookies[:remember_token])
        log_in user
        user
      end
    end
  end
end
