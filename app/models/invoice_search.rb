class InvoiceSearch

  attr_reader :date_from, :date_to

  def initialize(params)
    params ||= {}
    @date_from = parsed_date(params[:date_from], 7.days.ago.to_date.strftime("%d/%m/%Y"))
    @date_to = parsed_date(params[:date_to], Date.today.strftime("%d/%m/%Y"))    
  end
  
  # Searchs between date A and date Be
  def scope
    Invoice.where('date_of_an_invoice BETWEEN ? AND ?', @date_from, @date_to)  
  end

  private
  def parsed_date(date_string, default)
    Date.strptime(date_string, "%d/%m/%Y")
  rescue ArgumentError, TypeError
    default
  end
end