class SendMailActivationServices
  def send_mail_activate user
    UserMailer.account_activation(user).deliver_now
  end
end
