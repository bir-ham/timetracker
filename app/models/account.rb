class Account < ActiveRecord::Base
  RESTRICTED_SUBDOMAINS = %w(www)

  belongs_to :owner, class_name: 'User'

  validates :owner, presence: true
  validates :subdomain, presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: /\A[\w\-]+\Z/i, message: 'contains invalid characters' },
    exclusion: { in: RESTRICTED_SUBDOMAINS, message: 'restricted' }
  validates :industry, presence: false  
  validates :phone_number, presence: false  
  validates :email, presence: false  
  validates :address1, presence: false  
  validates :address2, presence: false  
  validates :zip, presence: false  
  validates :town, presence: false  
  validates :country, presence: false  

  #Temporary solution to resolve capybara's ElementNotFound error
  accepts_nested_attributes_for :owner

  before_validation :downcase_subdomain

  private
  def downcase_subdomain
    self.subdomain = subdomain.try(:downcase)
  end
end
