class Item < ActiveRecord::Base
  belongs_to :sale
  has_one :invoice, through: :sale

  validates :name, presence: true
  validates :quantity, presence: true, numericality: true
  validates :unit, presence: true
  validates :unit_price, presence: true
  validates :vat, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, message: 'Vat
   percentage should be between 0 and 100' }, allow_nil: true

  def self.paid_items_grouped_by_week(start)
    items = Item.joins(:sale, :invoice).where(invoices: {status: 'PAID', date_of_an_invoice: start.beginning_of_day..Time.zone.now})
    items.group_by { |i| i.invoice.date_of_an_invoice.beginning_of_week }
  end

  def self.pending_items_grouped_by_week(start)
    items = Item.joins(:sale, :invoice).where(invoices: {status: 'PENDING', date_of_an_invoice: start.beginning_of_day..Time.zone.now})
    items.group_by { |i| i.invoice.date_of_an_invoice.beginning_of_week }
  end

  def self.overdue_items_grouped_by_week(start)
    items = Item.joins(:sale, :invoice).where(invoices: {status: 'PENDING', date_of_an_invoice: start.beginning_of_day..Time.zone.now})
    items.group_by { |i| i.invoice.date_of_an_invoice.beginning_of_week }
  end

end
