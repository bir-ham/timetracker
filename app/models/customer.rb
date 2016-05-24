class Customer < ActiveRecord::Base
  validates :name, presence: true
  validates :phone_number, presence: true, uniqueness: true, allow_nil: true
  validates :email, presence: true, uniqueness: true, allow_nil: true
  validates :address, length: { maximum: 100, 
      too_long: "%{count} characters is the maximum allowed"

  validate :choose_xand_contact

  private
  def choose_xand_contact
    unless phone_number.blank? ^ email.blank?
      errors.add(:base, 'add a phone number or an email. Not both empty')        
    end
  end  
      
end
