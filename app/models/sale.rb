class Sale < ActiveRecord::Base

  has_one :invoice
  belongs_to :customer
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :customer, presence: true
  validates :user, presence: true
  validates :date, presence: true
  validates :status, presence: true, on: :update
  validates :description, presence: false

  validate :date_of_a_sale_cannot_be_in_the_past

  def self.grouped_by_week(start)
    sales = Sale.where(created_at: start.beginning_of_day..Time.zone.now)
    sales.group_by { |s| s.created_at.to_date.beginning_of_week }
  end

  def get_sales_without_invoice
    sales = Array.new
    for sale in Sale.all do
      sales.push(sale) if sale.invoice.nil?
    end
    return sales
  end

  private
    def date_of_a_sale_cannot_be_in_the_past
      if date.present? && date < Date.today
        errors.add(:date, "can't be in the past")
      end
    end

end
