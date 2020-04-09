class CustomersController < ApplicationController
  def index
    customers = Customer.includes(:company).as_json
    customers.each do |customer|
      customer[:company] = {} if customer[:company].nil?
    end 
    render json: customers
  end

  def create
    customer = Customer.create(customer_params)
    if customer.valid?
      customer.create_company!
      render json: customer
    else
      render json: customer.errors, status: :bad_request
    end
  end

  def update
    customer = Customer.find(params[:id])
    if customer.nil?
      render json: error_message, status: :not_found
    end
    customer.update(customer_params)
    if customer.valid?
      render json: customer
    else
      render json: customer.errors, status: :bad_request
    end
  end

  def destroy
    customer = Customer.find(params[:id])
    if customer.nil?
      render json: error_message, status: :not_found
    end
    customer.destroy
    render json: success_message, status: :no_content
  end

  private 
    def customer_params
      params.permit(:name, :code, :pic_name)
    end
end
