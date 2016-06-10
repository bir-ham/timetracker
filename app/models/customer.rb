class Customer < ActiveRecord::Base
  has_many :invoices

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :phone_number, presence: true, uniqueness: true, allow_blank: true,
    format: { with: /\A^\+?[0-9]{3}-?[0-9]{6,12}$\z/, on: :create, message: 'wrong phone number format' },
    length: { minimum: 10, maximum: 15, message: 'phone number must be b/n 10 to 15 characters' }
  validates :email, presence: true, uniqueness: true, allow_blank: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create ,message: 'wrong email format' }
  validates :address, length: { maximum: 100,
      too_long: "%{count} characters is the maximum allowed" }

  validate :any_or_both_phone_email

  private
  def any_or_both_phone_email
    if phone_number.blank? and email.blank?
      errors.add(:base, 'add a phone number or an email. Not both empty')
    end
  end

end
