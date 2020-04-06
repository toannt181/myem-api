class SessionsController < ApplicationController
  def store
    user_params = params.permit(:email, :password)

    user = User.find_by({ email: user_params[:email] })

    if user.is_authenticated?(user_params[:password])
      token = JsonWebToken.encode(email: user.email, id: user.id)
      render json: token
    else
      render status: :unauthorized
    end
  end
end
