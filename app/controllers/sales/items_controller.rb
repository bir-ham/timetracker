class Sales::ItemsController < ApplicationController

  def new
    @sale = Sale.find(params[:sale_id])
    @item = Item.new
  end

  def create
    @sale = Sale.find(params[:sale_id])
    @item = Item.new(item_params)
    total_price = params[:item][:quantity].to_i * params[:item][:unit_price].to_d
    @item.total = total_price
    @item.sale = @sale

    if @item.save
      redirect_to @sale, notice: I18n.t('sales.items.create.notice_create')
    else
      render :new
    end
  end

  # GET /sales/1
  def show
    @item = Item.find(params[:id])
  end

  # GET /sales/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash.now[:success] = I18n.t('sales.items.update.success_update')
      render :show
    else
      render :edit
    end
  end

  def destroy
    @sale = Sale.find(params[:sale_id])
    @item = Item.find(params[:id])
    name = @item.name
    if @item.destroy
      redirect_to @sale, notice: I18n.t('sales.items.destroy.success_delete', name: name)
    else
      flash.now[:error] = I18n.t('sales.items.distroy.error_delete')
    end
  end

  private
    def item_params
      params.require(:item).permit(:name, :quantity, :unit, :unit_price, :vat)
    end

end