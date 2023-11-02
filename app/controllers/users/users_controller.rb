class Users::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    user = get_user_from_token

    logged_user(user) && return if user

    no_logged_user
  end

  private

  def logged_user(user)
    render json: {
      user: {
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email
      }
      }, status: :ok
  end

  def no_logged_user
    render json: { message: "There is no logged user."}, status: :unauthorized
  end

  def get_user_from_token
    return if request.headers['Authorization'].nil?

    jwt_payload = JWT.decode(
                    request.headers['Authorization'].split(" ")[1],
                    Rails.application.credentials.devise[:jwt_secret_key]
                  ).first
    user_id = jwt_payload['sub']
    user = User.find(user_id.to_s)
  end
end
