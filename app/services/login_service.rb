class LoginService
  def initialize session
    @session = session
  end

  def log_in user
    @session[:user_id] = user.id
    @session[:created_at] = Time.zone.now
    @log = Log.create user_id: user.id, text: "You sign in at #{@session[:created_at]}"
  end
end
