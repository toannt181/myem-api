class ApplicationController < ActionController::API
  def index
    render json: { SERVER_STATUS: :active }
  end
end
