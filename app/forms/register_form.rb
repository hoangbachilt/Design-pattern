class RegisterForm
  include ActiveModel::Model
  attr_accessor :first_name, :last_name, :email, :password

  VALID_EMAIL_REGEX = Settings.email_regex
  USERS_PARAMS = %i(first_name last_name email password).freeze

  validates :email, presence: true,
                    format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true,
                       length: {minimum: Settings.password_length}
  validate :email_is_unique

  def perform_signup
    return false if invalid?

    user_attribute
    @user.save
    log_attribute
    @log.save
    true
  end

  def load_user
    @user
  end

  private

  def user_attribute
    @user = User.new do |user|
      user.first_name = first_name
      user.last_name = last_name
      user.email = email
      user.password = password
    end
  end

  def log_attribute
    @log = Log.new do |log|
      log.user_id = @user.id
      log.text = "You sign up at #{@user.created_at}"
    end
  end

  def email_is_unique
    if User.where(email: email).exists?
      errors.add(:email, "Email is taken")
    end
  end
end
