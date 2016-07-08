class Account < ActiveRecord::Base
  RESTRICTED_SUBDOMAINS = %w(www)

  belongs_to :owner, class_name: 'User'

  validates :owner, presence: true
  validates :subdomain, presence: true,
    uniqueness: true,
    format: { with: /\A[\w\-]+\Z/i, message: 'contains invalid characters' },
    exclusion: { in: RESTRICTED_SUBDOMAINS, message: 'restricted' }
  validates :industry, presence: false, allow_blank: true  
  validates :phone_number, presence: false, allow_blank: true,
    format: { with: /\A^\+?[0-9]{3}-?[0-9]{6,12}$\z/, on: :create, message: 'wrong phone number format' },
    length: { minimum: 10, maximum: 15, message: 'phone number must be b/n 10 to 15 characters' }
  validates :email, presence: false, allow_blank: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create ,message: 'wrong email format' } 
  validates :address1, presence: false, allow_blank: true,
    length: { maximum: 100, too_long: "%{count} characters is the maximum allowed" }  
  validates :address2, presence: false, allow_blank: true,
    length: { maximum: 100, too_long: "%{count} characters is the maximum allowed" }  
  validates :zip, presence: false, allow_blank: true, numericality: true
  validates :town, presence: false, allow_blank: true  
  validates :country, presence: false, allow_nil: true  

  mount_uploader :logo, LogoUploader 

  #Temporary solution to resolve capybara's ElementNotFound error
  accepts_nested_attributes_for :owner

  before_validation :downcase_subdomain

  private
    def downcase_subdomain
      self.subdomain = subdomain.try(:downcase)
    end
end
