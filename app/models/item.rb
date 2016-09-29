class Item < ActiveRecord::Base
  belongs_to :sale

  validates :name, presence: true
  validates :quantity, presence: true, numericality: true
  validates :unit, presence: true
  validates :unit_price, presence: true
  validates :vat, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, message: 'Vat
   percentage should be between 0 and 100' }, allow_nil: true


end
