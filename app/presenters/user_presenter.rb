class UserPresenter
  def initialize user
    @user = user
  end

  def get_logs
    logs = @user.logs
  end
end
