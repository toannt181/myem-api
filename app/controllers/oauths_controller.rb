class OauthsController < ApplicationController
  def store
    code = params[:code]
    return render status: :bad_request if !code
    oauth_user = GoogleToken.get_user_info(code)
    if !oauth_user
      return render json: { message: 'Authenticate fail' }, status: :unauthorized
    end
    user = User.new(email: oauth_user.email, name: oauth_user.name)
    user.save!
    user.oauths.create!(provider: 'Google')
    user.save!
    render json: user
  end
end
