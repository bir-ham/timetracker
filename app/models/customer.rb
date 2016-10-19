class Customer < ActiveRecord::Base
  has_many :sales, dependent: :destroy
  has_many :projects, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :phone_number, presence: true, uniqueness: true, allow_blank: true,
    format: { with: /\A^\+?[0-9]{3}-?[0-9]{6,12}$\z/, on: :create, message: 'wrong phone number format' },
    length: { minimum: 10, maximum: 15, message: 'phone number must be b/n 10 to 15 characters' }
  validates :email, presence: true, uniqueness: true, allow_blank: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create ,message: 'wrong email format' }
  validates :address, allow_blank: true,
    length: { maximum: 100, too_long: "%{count} characters is the maximum allowed" }

  validate :any_or_both_phone_email

  def get_this_week_customer_number
    Customer.where('created_at BETWEEN ? AND ?', Date.today.beginning_of_week, Date.today)
  end

  def self.grouped_by_week(start)
    customers = Customer.joins(:sales, :projects).where(created_at: start.beginning_of_day..Time.zone.now)
    customers.group_by { |c| c.created_at.to_date.beginning_of_week }
  end

  private
    def any_or_both_phone_email
      if phone_number.blank? and email.blank?
        errors.add(:base, 'add a phone number or an email. Not both empty')
      end
    end

end
