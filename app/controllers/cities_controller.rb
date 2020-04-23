class CitiesController < ApplicationController
  def index
    provinces = Province.all
    # districts = District.all
    # wards = Ward.all
    render json: provinces
  end

  def get_districts
    id = params[:city_id]
    begin
      province = Province.find(id)
      render json: province.districts
    rescue
      render json: fail_message, status: :not_found
    end
  end

  def get_wards
    id = params[:district_id]
    begin
      district = District.find(id)
      render json: district.wards
    rescue
      render json: fail_message, status: :not_found
    end
  end
end
