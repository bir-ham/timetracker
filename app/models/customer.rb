class Customer < ActiveRecord::Base
  validates :name, presence: true
  validates :phone, presence: true, uniqueness: true, allow_nil: true
  validates :email, presence: true, uniqueness: true, allow_nil: true
  validates :address, length: { maximum: 100, 
      too_long: "%{count} characters is the maximum allowed"
end
