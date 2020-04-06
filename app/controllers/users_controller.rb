class UsersController < ApplicationController
  before_action :authorization, only: :index

  def index
    render json: request['user']
  end

  def create
    valid_params = params.permit(:email, :password)
    user = User.new(email: valid_params[:email])
    user.password = valid_params[:password]
    user.save
    if user.valid?
      return render json: user
    end
  
    render json: user.errors, status: :bad_request
  end
end
