class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :item_params,only: [:index,:create]

  def index
    @order_shipping = OrderShipping.new
    redirect_to root_path if Order.exists?(item_id: @item.id) && user_signed_in?
    redirect_to root_path if user_signed_in? && @item.user == current_user
  end

  def create
    @order_shipping = OrderShipping.new(order_params)
    if @order_shipping.valid?
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']  # PAY.JPテスト秘密鍵
      Payjp::Charge.create(
        amount: @item.price,
        card: order_params[:token],
        currency: 'jpy'
      )
      @order_shipping.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_shipping).permit(:postcode, :prefecture_id, :city, :block, :building, :phone_number)
          .merge(item_id: @item.id, user_id: current_user.id, token: params[:token])
  end

  def item_params
    @item = Item.find(params[:item_id])
  end
end
