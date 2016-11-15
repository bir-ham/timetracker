class Sale < ActiveRecord::Base

  belongs_to :user
  has_one :invoice
  belongs_to :customer
  has_many :items, dependent: :destroy

  validates :customer, presence: true
  validates :date, presence: true
  validates :status, presence: true, on: :create
  validates :description, presence: false

  validate :date_of_a_sale_cannot_be_in_the_past

  self.per_page = 10

  def self.all_waiting_by_status
    sales = Sale.where(status: 'WAITING')
    sales_count = sales.group(:status).count
  end

  def self.grouped_by_week(start)
    sales = Sale.where(created_at: start.beginning_of_day..Time.zone.now)
    sales.group_by { |s| s.created_at.to_date.beginning_of_week }
  end

  def self.get_sales_without_invoice
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
