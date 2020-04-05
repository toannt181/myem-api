class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def create
    valid_params = params.require(:user).permit(:email, :password)

    user = User.new(email: valid_params[:email])
    user.password = valid_params[:passord]
    user.save
    if user.valid?
      return render json: user
    end
    
    render json: user.errors, status: :bad_request
  end
end
