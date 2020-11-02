class ActivatedService
  def initialize session
    @session = session
  end

  def activate user
    if user.activated?
      @log_in = LoginService.new @session
      @log_in.log_in user
    end
  end
end
