class Invoice < ActiveRecord::Base
  attr_writer :current_step

  belongs_to :customer
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :customer, presence: true, if: lambda { |o| o.current_step == 'customer' }
  validates :user, presence: true, if: lambda { |o| o.current_step == 'invoice' }
  validates :date_of_an_invoice, presence: true, if: lambda { |o| o.current_step == 'invoice' }
  validates :deadline, presence: true, allow_nil: true, if: lambda { |o| o.current_step == 'invoice' }
  validates :payment_term, presence: true, allow_nil: true, if: lambda { |o| o.current_step == 'invoice' }
  validates :interest_in_arrears, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, message: 'Interest on arrears
    percentage should be between 0 and 100' }, allow_nil: true, if: lambda { |o| o.current_step == 'invoice' }
  validates :reference_number, presence: true,
    uniqueness: true,
    numericality: { greater_than_or_equal_to: 0 }, if: lambda { |o| o.current_step == 'invoice' }
  validates :description, length: { maximum: 300,
    too_long: "%{count} characters is the maximum allowed" }, if: lambda { |o| o.current_step == 'invoice' }

  validate :choose_xor_deadline_payment_term
  validate :date_of_an_invoice_or_deadline_cannot_be_in_the_past

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |invoice|
        csv << invoice.attributes.values_at(*column_names)
      end
    end
  end

  def current_step
    @current_step || steps.first
  end

  def steps
    %w[customer invoice confirmation]
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

  def last_step?
    current_step == steps.last
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end

  private
    def choose_xor_deadline_payment_term
      unless deadline.blank? ^ payment_term.blank?
        errors.add(:base, 'specify a deadline or a payment term. Not both empty, nor both filled')
      end
    end

  private
    def date_of_an_invoice_or_deadline_cannot_be_in_the_past
      if date_of_an_invoice.present? && date_of_an_invoice < Date.today
        errors.add(:date_of_an_invoice, "can't be in the past")
      end
      if deadline.present? && deadline < Date.today
        errors.add(:deadline, "can't be in the past")
      end
    end

end
