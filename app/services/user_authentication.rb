class UserAuthentication
  def initialize(params)
    @params = params
  end


  def login
    return OpenStruct.new(message: "User not found!", status: 404) unless User.exists?(email: user_params[:email])

    user = User.find_by(email: user_params[:email])
    return OpenStruct.new(message: "Invalid email password combination", status: 400) unless user.valid_password?(user_params[:password])

    return OpenStruct.new(message: "Your account is inactive! Please confirm your email first", status: 400) unless user.confirmed?

    return_user(user,"Login Successfully")

  end

  def signup
    if !User.exists?(email: user_params[:email])
      resource = User.new(user_params)
      if resource.save
        return_user(resource, "Account Created")
      else
        OpenStruct.new(message: resource.errors.full_messages[0], status: 400)
      end
    else
      OpenStruct.new(message: "User already exists", status: 400)
    end
  end

  def user_params
    @params.require(:user).permit(:email, :password, :phone_no, :first_name, :last_name)
  end

  def return_user(user, message)
    token = JWT.encode({user_id: user.id},Rails.application.secrets.secret_key_base, 'HS256')
    OpenStruct.new(user: UserSerializer.new(user,root: false, serializer_options: {token: token}), message: message, status: 200 )
  end


end
