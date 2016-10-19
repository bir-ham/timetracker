class InvoicesController < ApplicationController
  #before_action :set_invoice, only: [:show, :edit, :upate, :destroy]

  def index
    @invoices = Invoice.all

    respond_to do |format|
      format.html
      format.json { render json: InvoicesDatatable.new(view_context) }
      format.csv { render text: @invoices.to_csv }
      format.xls #{ render text: @invoices.to_csv(col_sep: "\t") }
    end
  end

  def new
    session[:invoice_params] ||= {}
    @invoice = Invoice.new(session[:invoice_params])
    @invoice.current_step = session[:invoice_step]

    @sales = Sale.new.get_sales_without_invoice
    @projects = Project.new.get_projects_without_invoice
  end

  def create
    session[:invoice_params].deep_merge!(params[:invoice]) if params[:invoice]
    @invoice = Invoice.new(session[:invoice_params])
    @invoice.current_step = session[:invoice_step]

    @sales = Sale.get_sales_without_invoice
    @projects = Project.get_projects_without_invoice

    if @invoice.valid?
      if params[:back_button]
        @invoice.previous_step
      elsif @invoice.last_step?
        @invoice.status = 'PENDING'
        @invoice.save if @invoice.all_valid?
      else
        @invoice.next_step
      end
      session[:invoice_step] = @invoice.current_step
    end
    if @invoice.new_record?
      render 'new'
    else
      session[:invoice_step] = session[:invoice_params] = nil
      redirect_to invoices_path, notice: I18n.t('invoices.create.notice_create')
    end
  end

  # GET /invoices/1
  def show
    @invoice = Invoice.find(params[:id])
  end

  # GET /invoices/1/edit
  def edit
    @invoice = Invoice.find(params[:id])
    @sales = Sale.get_sales_without_invoice
  end

  def update
    @invoice = Invoice.find(params[:id])
    @sales = Sale.get_sales_without_invoice
    if @invoice.update_attributes(invoice_params)
      flash.now[:success] = I18n.t('invoices.update.success_update')
      render :show
    else
      render :edit
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    if @invoice.destroy
      redirect_to invoices_url, notice: I18n.t('invoices.destroy.success_delete')
    else
      flash.now[:error] = I18n.t('invoices.distroy.error_delete')
    end
  end

  def clear_invoice_params
    session[:invoice_step] = session[:invoice_params] = nil
    redirect_to invoices_url
  end

  private
    def invoice_params
      params.require(:invoice).permit(:date_of_an_invoice, :deadline, :payment_term, :interest_in_arrears,
        :reference_number, :status, :description, :sale_id, :project_id, :customer_id, :user_id)
    end

end