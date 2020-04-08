class SessionsController < ApplicationController
  def create
    user_params = params.permit(:email, :password)

    if user_params[:email].empty? || user_params[:password].empty?
      return render status: :bad_request
    end

    user = User.find_by({ email: user_params[:email] })

    if user.is_authenticated?(user_params[:password])
      token = JsonWebToken.encode(email: user.email, id: user.id)
      render json: token
    else
      render json: fail_message, status: :unauthorized
    end
  end
end
