class SigninForm
  include ActiveModel::Model
  attr_accessor :email, :password

  VALID_EMAIL_REGEX = Settings.email_regex

  validates :email, presence: true,
                    format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true,
                       length: {minimum: Settings.password_length}
end
