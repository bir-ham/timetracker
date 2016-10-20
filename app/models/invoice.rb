class Invoice < ActiveRecord::Base
  attr_accessor :current_step

  belongs_to :user
  belongs_to :sale
  belongs_to :project

  validates :user, presence: true, if: lambda { |i| i.current_step == 'user_sale_project' }
  validates :sale, presence: true, allow_nil: true, if: lambda { |i| i.current_step == 'user_sale_project' }
  validates :project, presence: true, allow_nil: true, if: lambda { |i| i.current_step == 'user_sale_project' }
  validates :date_of_an_invoice, presence: true, if: lambda { |i| i.current_step == 'invoice' }
  validates :deadline, presence: true, allow_nil: true
  validates :payment_term, presence: true, allow_nil: true
  validates :interest_in_arrears, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, message: 'Interest on arrears
    percentage should be between 0 and 100' }, allow_nil: true, if: lambda { |i| i.current_step == 'invoice' }
  validates :reference_number, presence: true,
    uniqueness: true,
    numericality: { greater_than_or_equal_to: 0 }, if: lambda { |i| i.current_step == 'invoice' }
  validates :status, presence: false, if: lambda { |i| i.current_step == 'invoice' }
  validates :description, length: { maximum: 300,
    too_long: "%{count} characters is the maximum allowed" }, if: lambda { |i| i.current_step == 'invoice' }

  validate :choose_xor_sale_project, if: lambda { |i| i.current_step == 'user_sale_project' }
  validate :choose_xor_deadline_payment_term, if: lambda { |i| i.current_step == 'invoice' }
  validate :date_of_an_invoice_or_deadline_cannot_be_in_the_past, if: lambda { |i| i.current_step == 'invoice' }

  # setter
  def current_step
    @current_step || steps.first
  end

  def steps
    %w[user_sale_project invoice confirmation]
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def second_step?
    current_step == steps.second
  end

  def last_step?
    current_step == steps.last
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end

  def self.all_unpaid_invoices_by_status
    unpaid_invoices = Hash.new
    unpaid_invoices['pending'] = Invoice.where(status: 'PENDING')
    unpaid_invoices['overdue'] = Invoice.where(status: 'OVERDUE')
    return unpaid_invoices
    #unpaid_invoices_counted = unpaid_invoices.group(:status).count
  end

  private
    def choose_xor_deadline_payment_term
      unless deadline.blank? ^ payment_term.blank?
        errors.add(:base, 'specify deadline or payment term. Not both filled, nor both empty')
      end
    end

    def choose_xor_sale_project
      unless sale.blank? ^ project.blank?
        errors.add(:base, 'specify sale or project. Not both filled, nor both empty')
      end
    end

    def date_of_an_invoice_or_deadline_cannot_be_in_the_past
      if date_of_an_invoice.present? && date_of_an_invoice < Date.today
        errors.add(:date_of_an_invoice, "can't be in the past")
      end
      if deadline.present? && deadline < Date.today
        errors.add(:deadline, "can't be in the past")
      end
    end

end
