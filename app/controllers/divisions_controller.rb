class DivisionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])
    render json: customer.divisions.order(sort: :asc)
  end

  def create
    data = params.permit(data: [:name, :id])[:data]
    data.each_with_index do |item, index|
      item[:sort] = index
      item[:customer_id] = params[:customer_id]

      if item[:id]
        Division.find(item[:id]).update(item)
      else
        Division.create(item)
      end
    end
    
    render json: success_message
  end

  def destroy
    Division.find(params[:id]).destroy
  end
end
