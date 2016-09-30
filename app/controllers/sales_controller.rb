class SalesController < ApplicationController

  def index
    @sales = Sale.all
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.status = 'PENDING'
    if @sale.save
      redirect_to sales_path, notice: I18n.t('sales.create.notice_create')
    else
      render :new
    end
  end

  # GET /sales/1
  def show
    @sale = Sale.find(params[:id])
    @item = Item.new
  end

  # GET /sales/1/edit
  def edit
    @sale = Sale.find(params[:id])
    @item = Item.new
  end

  def update
    @sale = Sale.find(params[:id])
    if @sale.update_attributes(sale_params)
      flash.now[:success] = I18n.t('sales.update.success_update')
      render :show
    else
      render :edit
    end
  end

  def destroy
    @sale = Sale.find(params[:id])
    if @sale.destroy
      redirect_to @sale, notice: I18n.t('sales.destroy.success_delete')
    else
      flash.now[:error] = I18n.t('sales.distroy.error_delete')
    end
  end

  private

  def sale_params
    params.require(:sale).permit(:date, :customer_id, :status, :user_id, :description)
  end

end