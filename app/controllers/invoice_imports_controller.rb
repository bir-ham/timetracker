class InvoiceImportsController < ApplicationController
  def new
    @invoice_import = InvoiceImport.new
  end

  def create
    @invoice_import = InvoiceImport.new(params[:invoice_import])
    if @invoice_import.save
      redirect_to invoices_path, notice: "Imported products successfully."
    else
      render :new
    end
  end

  
end