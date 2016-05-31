class Invoice < ActiveRecord::Base

  validates :customer, presence: true
  validates :date_of_an_invoice, presence: true
  validates :deadline, presence: true, allow_nil: true
  validates :payment_term, presence: true, allow_nil: true
  validates :interest_in_arrears, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, message: 'Interest on arrears 
    percentage should be between 0 and 100' }, allow_nil: true
  validates :reference_number, presence: true, 
    uniqueness: true,
    numericality: { greater_than_or_equal_to: 0 }
  validates :description, length: { maximum: 300,
    too_long: "%{count} characters is the maximum allowed" }

  validate :choose_xor_deadline_payment_term
  validate :date_of_an_invoice_or_deadline_cannot_be_in_the_past

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

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    begin
      #CSV.foreach(file.path, headers: true) do |row|
      #  Invoice.create! row.to_hash
      #end
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        invoice = find_by_id(row["id"]) || new
        invoice.attributes = row.to_hash.slice(*accessible_attributes)
        invoice.save!
      end
    rescue CSV::MalformedCSVError => e
      return :errors => 'File type not supported. Only .xls and .csv formats allowed'
    rescue NoMethodError => e
      return :errors => 'No file selected'
    rescue ActiveRecord::RecordInvalid => e
      tokens = e.message.split(':')
      err_msgs = tokens[1].split(',')
      return :errors =>  err_msgs
    rescue Exception => e
      return :errors => e.message
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, csv_options: {encoding: "iso-8859-1:utf-8"})
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unkown file type: #{file.original_filename}"    
    end
  end 
    
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |invoice|
        csv << invoice.attributes.values_at(*column_names)
      end  
    end
  end
end
