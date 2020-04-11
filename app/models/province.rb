class Province < ApplicationRecord
  self.table_name = 'province'
  has_many :districts
end
