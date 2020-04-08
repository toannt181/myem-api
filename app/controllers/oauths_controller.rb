class OauthsController < ApplicationController
  def create
    code = params[:code]
    return render status: :bad_request if !code
    oauth_user = GoogleToken.get_user_info(code)
    if !oauth_user
      return render json: { message: 'Authenticate fail' }, status: :unauthorized
    end

    user = User.find_by(email: oauth_user.email)
    if !user
      user = User.new(email: oauth_user.email, name: oauth_user.name)
      user.save!
      user.oauths.create!(provider: 'Google')
      user.save!
    end

    token = JsonWebToken.encode(email: user.email, id: user.id)
    render json: token
  end
end
