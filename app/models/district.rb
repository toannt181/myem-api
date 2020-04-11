class District < ApplicationRecord
  self.table_name = 'district'
  has_many :wards
end
