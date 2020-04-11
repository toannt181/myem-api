class CompaniesController < ApplicationController
  def company_info
    customer = Customer.find(params[:customer_id])
    company = customer.company
    company = customer.create_company if company.nil?
    render json: company
  end

  def update
    company_params = params.permit(:ward_id, :province_id, :district_id)
    company = Company.find(params[:id])
    company.update(company_params)
    render json: success_message
  end
end
