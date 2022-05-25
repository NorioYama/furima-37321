require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  describe '購入機能' do
    before do
      item = FactoryBot.create(:item)
      user = FactoryBot.create(:user)
      @order_shipping = FactoryBot.build(:order_shipping, user_id: user.id, item_id: item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_shipping).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @order_shipping.building = ''
        expect(@order_shipping).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が空では登録できない' do
        @order_shipping.postcode = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Postcode can't be blank")
      end
      it '郵便番号に（ー）ハイフンが入ってなければ登録できない' do
        @order_shipping.postcode = '4570988'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Postcode is invalid. Include hyphen(-)')
      end
      it '都道府県を選ばなければ登録できない' do
        @order_shipping.prefecture_id = '1'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空では登録できない' do
        @order_shipping.city = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空では登録できない' do
        @order_shipping.block = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Block can't be blank")
      end
      it '電話番号が空ては登録できない' do
        @order_shipping.phone_number = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が（ー）ハイフンが入っていては登録できない' do
        @order_shipping.phone_number = '052-000-000'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が9桁以下では登録できない' do
        @order_shipping.phone_number = '052000000'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上では登録できない' do
        @order_shipping.phone_number = '052000000000'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number is invalid')
      end
      it 'tokenが空では登録できないこと' do
        @order_shipping.token = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Token can't be blank")
      end
      it 'userが紐付いていなければ購入できない' do
        @order_shipping.user_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていなければ購入できない' do
        @order_shipping.item_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
