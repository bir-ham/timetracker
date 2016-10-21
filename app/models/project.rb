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

  # for the Post model
  self.per_page = 10

  def self.all_new_delayed_by_status
    projects = Project.where('status = ? or status = ?', 'NEW', 'DELAYED')
    projects_count = projects.group(:status).count
  end

  def self.grouped_by_week(start)
    projects = Project.where(created_at: start.beginning_of_day..Time.zone.now)
    projects.group_by { |p| p.created_at.to_date.beginning_of_week }
  end

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
