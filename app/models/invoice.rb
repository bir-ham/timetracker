class Invoice < ActiveRecord::Base
  validates :customer, presence: true
  validates :date_of_an_invoice, presence: true
  validates :deadline, presence: true, allow_nil: true
  validates :payment_term, presence: true, allow_nil: true
  validates :interest_in_arrears, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, message: 'Interest on arrears 
    percentage should be between 0 and 100' }, allow_nil: true
  validates :reference_number, presence: true, 
    uniqueness: true,
    numericality: { greater_than_or_equal_to: 0 }
  validates :description, length: { maximum: 300,
    too_long: "%{count} characters is the maximum allowed" }

  validate :choose_xor_date

  private
  def choose_xor_date
    unless deadline.blank? ^ payment_term.blank?
      errors.add(:base, 'specify a deadline or a payment term. Not both empty, nor both filled')        
    end
  end  

end
