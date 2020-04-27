class DivisionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])
    divisions = customer.company.diagnosis.divisions.order(sort: :asc)
    render json: divisions
  end

  def create
    data = params.permit(data: [:name, :id])[:data]
    customer = Customer.find(params[:customer_id])
    diagnosis_id = customer.company[:current_diagnosis]
    data.each_with_index do |item, index|
      item[:sort] = index
      item[:diagnosis_id] = diagnosis_id

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
