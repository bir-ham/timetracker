class Sale < ActiveRecord::Base

  belongs_to :invoice
  belongs_to :customer
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :customer, presence: true
  validates :user, presence: true
  validates :status, presence: true, on: :edit
  validates :description, presence: false

  validate :date_of_a_sale_cannot_be_in_the_past

  private
    def date_of_a_sale_cannot_be_in_the_past
      if date.present? && date < Date.today
        errors.add(:date, "can't be in the past")
      end
    end
end
