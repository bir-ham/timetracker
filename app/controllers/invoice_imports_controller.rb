class InvoiceImportsController < ApplicationController
  def index
    @invoice_import = InvoiceImport.new
  end

  def create
    @invoice_import = InvoiceImport.new(params[:invoice_import])
    if @invoice_import.save
      redirect_to invoices_path, notice: "Imported products successfully."
    elsif @invoice_import.errors.any? 
      #= pluralize(@invoice_import.errors.count, "error") 
      #|&nbsp;prohibited this import from completing:
      flash.now[:alert] = @invoice_import.errors.messages[:base]
      render :index
    end
  end


end