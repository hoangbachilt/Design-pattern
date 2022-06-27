class SessionsController < ApplicationController
  def new; end

  def create
    signin_form = SigninForm.new signin_params
    activated = ActivatedService.new session
    user = User.find_by email: params[:signin_form][:email].downcase
    if signin_form.valid? && user&.authenticate(params[:signin_form][:password]).present?
      activated.activate user
      redirect_to user
    else
      flash[:warning] = "Log in fail!!!"
      redirect_to signin_path
    end
  end

  private

  def signin_params
    params.require(:signin_form).permit :email, :password
  end
end
