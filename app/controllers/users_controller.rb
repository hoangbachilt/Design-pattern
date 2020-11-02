class UsersController < ApplicationController

  def show
    presenter = UserPresenter.new current_user
    @logs = presenter.get_logs
  end

  def new
    @register_form = RegisterForm.new
  end

  def create
    register_form = RegisterForm.new register_params
    send_mail = SendMailActivationServices.new
    if register_form.perform_signup
      user = register_form.load_user
      send_mail.send_mail_activate user
      flash[:success] = "Sign up success !!!"
      render :show
    else
      flash[:danger] = "Sign up fail. Check name, email, password !!!"
      render :new
    end
  end

  private

  def register_params
    params.require(:register_form).permit User::USERS_PARAMS
  end
end
