class OrderShipping
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postcode, :prefecture_id, :city, :block, :building, :phone_number, :token

  with_options presence: true do
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }
    validates :city, :block, :item_id, :user_id, :token
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Shipping.create(postcode: postcode, prefecture_id: prefecture_id, city: city, block: block, building: building,
                    phone_number: phone_number, order_id: order.id)
  end
end
