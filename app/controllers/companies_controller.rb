class CompaniesController < ApplicationController
  def company_info
    customer = Customer.find(params[:customer_id])
    company = customer.company
    company = customer.create_company if company.nil?
    render json: company
  end

  def update
    company_params = params.permit(:ward_id, :province_id, :district_id, :current_diagnosis)
    begin
      company = Company.find(params[:id])
      province = Province.find(company_params[:province_id])
      district = province.districts.find(company_params[:district_id])
      ward = district.wards.find(company_params[:ward_id])
      company.update(company_params)
      render json: success_message
    rescue => e
      render json: e, status: :not_found
    end
  end

  def show
    render json: params
  end
end
