class InvoiceImportsController < ApplicationController
  def index
    @invoice_import = InvoiceImport.new
  end

  def create
    @invoice_import = InvoiceImport.new(params[:invoice_import])
    if @invoice_import.save
      redirect_to invoices_path, notice: I18n.t('invoice_imports.create.success_import')
    elsif @invoice_import.errors.any? 
      flash.now[:alert] = @invoice_import.errors.messages[:base]
      render :index
    end
  end


end