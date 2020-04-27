class Customer < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  has_one :company
  has_many :divisions
  has_many :diagnoses

  def as_json(options = {})
    options = { 
      include: :company,
    }.update(options)
    super(options)
  end
end
