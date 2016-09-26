class Item < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :project

  validates :name, presence: true
  validates :date, presence: true
  validates :quantity, presence: true, numericality: true
  validates :unit, presence: true
  validates :unit_price, presence: true
  validates :vat, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, message: 'Vat
   percentage should be between 0 and 100' }, allow_nil: true

  validate :date_of_an_item_cannot_be_in_the_past

   private
    def date_of_an_item_cannot_be_in_the_past
      if date.present? && date < Date.today
        errors.add(:date, "can't be in the past")
      end
    end

end
