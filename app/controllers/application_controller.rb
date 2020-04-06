class ApplicationController < ActionController::API
  def index
    render json: { SERVER_STATUS: :active }
  end

  def authorization
    token = request.headers['Authorization']
    access_token = token.split(' ')[1] if token
    
    if !access_token
      return render status: :unauthorized
    end

    begin
      jwt = JsonWebToken.decode(access_token)
      request['user'] = jwt[0]
    rescue JWT::DecodeError => e
      render json: 'token error', status: :unauthorized
    end
  end
end
