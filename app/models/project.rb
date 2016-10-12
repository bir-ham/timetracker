class Project < ActiveRecord::Base

  has_one :invoice
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

  def get_projects_without_invoice
    projects = Array.new
    for project in Project.all do
      projects.push(project) if project.invoice.nil?
    end
    return projects
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |invoice|
        csv << invoice.attributes.values_at(*column_names)
      end
    end
  end

end
