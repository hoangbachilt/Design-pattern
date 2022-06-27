class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated?
      ActivatedService.activate user
      flash[:success] = "Activated account !!!"
      redirect_to user
    else
      flash[:danger] = "Activate fail !!!"
      redirect_to root_path
    end
  end
end
