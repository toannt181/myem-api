require 'csv'    

class CustomersController < ApplicationController
  DIRECTION = { '1': :desc, '2': :asc }
  ORDER = { '5': :code, '6': :name, '7': :pic_name }

  def index
    page = params[:page].to_i || 1
    limit = params[:limit].to_i || Rails.configuration.x.limit
    offset = (page - 1) * Rails.configuration.x.per_page
    sort_by = ORDER[params[:sort].to_sym] || :created_at
    direction = DIRECTION[params[:order].to_sym] || :desc
    order = Hash[sort_by, direction]

    query = Customer.includes(:company)
      .order(order)

    if (params[:code])
      query = query.where('code LIKE ?', "%#{params[:code]}%")
    end

    if (params[:name])
      query = query.where('name LIKE ?', "%#{params[:name]}%")
    end

    if (params[:pic_name])
      query = query.where('pic_name LIKE ?', "%#{params[:pic_name]}%")
    end

    total = query.count
    customers = query
      .offset(offset)
      .limit(limit)
      .as_json
    customers.each do |customer|
      customer[:company] = {} if customer[:company].nil?
    end 
    render json: { data: customers, meta: { from: offset + 1, to: offset + customers.length, total: total, page: page, limit: limit } }
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

  def sample
    render json: { shift_jis: customers_utf8_path, utf_8: customers_utf8_path }
  end

  def csv
    send_file(
      "#{Rails.root}/public/customer_utf8.csv",
    )
  end

  def preview
    file = params[:file]
    if file
      csv_text = File.read(params[:file])
      csv_array = CSV.parse(csv_text, :headers => true)
      customers = []
      errors = {}
      if (csv_array.headers - ['code', 'name', 'pic_name']).length == 0
        csv_array.each_with_index do |row, index|
          customer = row.to_h
          customers << customer
        end
        log = Log.create!(status: 0, action: :CustomersImportJob)
        CustomersImportJob.set(wait: 1.second).perform_later(log.id, customers)
        return render json: customers
      end
      return render json: { 'line_1': 'Error' }, status: :bad_request
    end
    render json: error_message, status: :bad_request
  end

  private 
    def customer_params
      params.permit(:name, :code, :pic_name)
    end
end
