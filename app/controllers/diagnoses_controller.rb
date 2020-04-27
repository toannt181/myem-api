class DiagnosesController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])
    render json: customer.diagnoses
  end

  def create
    customer = Customer.find(params[:customer_id])
    data = params.permit(:name, :year)
    customer.diagnoses.create(data)
    render json: success_message
  end
end
