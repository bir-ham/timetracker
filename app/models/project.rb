class Project < ActiveRecord::Base
  
  belongs_to :invoice
  belongs_to :customer
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :status, presence: true 
  validates :progress, presence: true, allow_nil: true

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |invoice|
        csv << invoice.attributes.values_at(*column_names)
      end
    end
  end

end
