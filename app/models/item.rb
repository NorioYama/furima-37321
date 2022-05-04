class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :condition, :days_to_ship, :prefecture, :shipping_fee

  validates :image, :product_name, :product_description, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                    format: { with: /\A[0-9]+\z/ }

  validates :category_id, :condition_id, :days_to_ship_id, :prefecture_id, :shipping_fee_id,
            numericality: { other_than: 1, message: "can't be blank" }
end
