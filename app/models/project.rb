class Project < ActiveRecord::Base

  belongs_to :invoice
  belongs_to :customer
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :customer, presence: true
  validates :user, presence: true
  validates :name, presence: true, uniqueness: true
  validates :deadline, presence: false
  validates :status, presence: true, on: :edit
  validates :progress, presence: true, allow_nil: true
  validates :description, presence: false

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |invoice|
        csv << invoice.attributes.values_at(*column_names)
      end
    end
  end

end
