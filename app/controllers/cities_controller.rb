class CitiesController < ApplicationController
  def index
    provinces = Province.all
    # districts = District.all
    # wards = Ward.all
    render json: provinces
  end
end
