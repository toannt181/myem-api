class Company < ApplicationRecord
  belongs_to :customer

  belongs_to :diagnosis, class_name: 'Diagnosis', foreign_key: 'current_diagnosis'
end
