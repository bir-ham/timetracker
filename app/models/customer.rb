class Customer < ActiveRecord::Base
  validates :name, presence: true
  validates :phone_number, presence: true, uniqueness: true, allow_nil: true,
    numericality: { greater_than_or_equal_to: 10, less_than_or_equal_to: 15, message: 'Phone nubmer 
    should be between 10 and 15' }
  validates :email, presence: true, uniqueness: true, allow_nil: true
  validates :address, length: { maximum: 100, 
      too_long: "%{count} characters is the maximum allowed" }

  validate :choose_xand_contact
  
  private
  def choose_xand_contact
    if phone_number.blank? ^ email.blank?
      errors.add(:base, 'add a phone number or an email. Not both empty')        
    end
  end  
      
end
