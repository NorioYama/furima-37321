class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :item_find_params, only: [:show, :update, :edit]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    redirect_to action: :index unless current_user == @item.user
    redirect_to action: :index if Order.exists?(item_id: @item.id) 
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy if user_signed_in? && current_user == item.user
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item)
          .permit(:product_name, :product_description, :category_id, :condition_id,
                  :shipping_fee_id, :prefecture_id, :days_to_ship_id, :price, :image)
          .merge(user_id: current_user.id)
  end

  def item_find_params
    @item = Item.find(params[:id])
  end
end
