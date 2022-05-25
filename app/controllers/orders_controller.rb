class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @order_shipping = OrderShipping.new
    @item = Item.find(params[:item_id])
    redirect_to root_path if Order.exists?(@item.id) && user_signed_in? && current_user != @item.user
    redirect_to root_path if user_signed_in? && current_user == @item.user
  end

  def create
    @item = Item.find(params[:item_id])
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
end
