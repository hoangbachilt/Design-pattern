class CreateActivationDigestServices
  attr_accessor :activation_token

  def create_activation_digest user
      user.activation_token  = User.new_token
      user.activation_digest = User.digest activation_token
    end
end
