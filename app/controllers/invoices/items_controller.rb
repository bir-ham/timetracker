class Invoices::ItemsController < ApplicationController

  def index
    @items = Item.all

  end

  def new
    @invoice = Invoice.find(params[:invoice_id])
    @item = Item.new
  end

  def create
    @invoice = Invoice.find(params[:invoice_id])
    @item = Item.new(item_params)
    @item.invoice = @invoice

    if @item.save
      redirect_to @invoice, notice: I18n.t('invoices.items.create.notice_create')
    else
      render :new
    end
  end

  # GET /invoices/1
  def show
    @item = Item.find(params[:id])
  end

  # GET /invoices/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash.now[:success] = I18n.t('invoices.items.update.success_update')
      render :show
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      redirect_to invoices_url, notice: I18n.t('invoices.items.destroy.success_delete')
    else
      flash.now[:error] = I18n.t('invoices.items.distroy.error_delete')
    end
  end

  private
    def item_params
      params.require(:item).permit(:description, :date, :quantity, :unit, :unit_price, :vat)
    end

end