class Task < ActiveRecord::Base
  belongs_to :project

  validates :name, presence: true
  validates :hours, presence: true,
      format: { with: /\A[0-9]+:\z/, message: 'should be only numbers and colon' }
  validates :payment_type, presence: true
  validates :price, presence: true
  validates :vat, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, message: 'Vat
   percentage should be between 0 and 100' }, allow_nil: true


end
