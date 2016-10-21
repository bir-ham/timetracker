class Task < ActiveRecord::Base
  belongs_to :project
  has_one :invoice, through: :project

  validates :name, presence: true
  validates :hours, presence: true,
      format: { with: /\A^[:,0-9]+$\z/, message: 'should be only numbers and colon' }
  validates :payment_type, presence: true
  validates :price, presence: true
  validates :vat, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, message: 'Vat
   percentage should be between 0 and 100' }, allow_nil: true

  def self.all_paid_tasks
    tasks = Task.joins(:invoice).where(invoices: {status: 'PAID'}).sum(:total)
  end

  def self.paid_tasks_grouped_by_week(start)
    tasks = Task.joins(:invoice).where(invoices: {status: 'PAID', date_of_an_invoice: start.beginning_of_day..Time.zone.now})
    tasks.group_by { |i| i.invoice.date_of_an_invoice.beginning_of_week }
  end

  def self.pending_tasks_grouped_by_week(start)
    tasks = Task.joins(:invoice).where(invoices: {status: 'PENDING', date_of_an_invoice: start.beginning_of_day..Time.zone.now})
    tasks.group_by { |i| i.invoice.date_of_an_invoice.beginning_of_week }
  end

  def self.overdue_tasks_grouped_by_week(start)
    tasks = Task.joins(:invoice).where(invoices: {status: 'OVERDUE', date_of_an_invoice: start.beginning_of_day..Time.zone.now})
    tasks.group_by { |i| i.invoice.date_of_an_invoice.beginning_of_week }
  end

end
