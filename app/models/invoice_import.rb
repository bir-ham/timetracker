class InvoiceImport

  def self.load_imported_invoices(file)
    @errors = nil
    @spreadsheet
    begin
      @spreadsheet = open_spreadsheet(file)
    rescue CSV::MalformedCSVError => e
      return :errors => 'File type not supported. Only .xls and .csv formats allowed'
    rescue NoMethodError => e
      return :errors => 'No file selected'
    rescue Exception => e
      return :errors => e.message
    end  
    header = @spreadsheet.row(1)
    #CSV.foreach(file.path, headers: true) do |row|
    #  Invoice.create! row.to_hash
    #end
    (2..@spreadsheet.last_row).each do |i|
      row = Hash[[header, @spreadsheet.row(i)].transpose]
      #invoice = Invoice.find_by_id(row["id"]) || Invoice.new
      invoice = Invoice.new
      invoice.attributes = row.to_hash
      if invoice.save        
        next     
      else 
        @errors = invoice.errors.messages
        break  
      end
    end 
    return @errors
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, csv_options: {encoding: "iso-8859-1:utf-8"})
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
