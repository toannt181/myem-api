class CustomersImportJob < ApplicationJob
  queue_as :default

  def perform(id, rows)
    log = Log.find(id)
    begin
      log.update(status: 1)
      errors = {}
      customers = []
      rows.each_with_index do |row, index|
        customer = Customer.new(row)
        customers << customer
        if !customer.valid?
          errors["line_#{index + 1}".to_sym] = customer.errors.messages
        end
      end
      if errors.empty?
        customers.each { |customer| customer.save }
        log.update(status: 2)
      else
        log.update(status: 3, content: errors)
      end
    rescue => e
      log.update(status: 3, content: e.backtrace.inspect)
    end
  end
end
