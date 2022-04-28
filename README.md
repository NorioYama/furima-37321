## users table

|     Column         |  Type   |      Option        |
|---------------------------------------------------|
| nickname           | string  | NOT NULL           |
| email              | string  | NOT NULL           |
| encrypted_password | string  | NOT NULL           |
| last_name          | string  | NOT NULL           |
| first_name         | string  | NOT NULL           |
| last_name_kana     | string  | NOT NULL           |
| first_name_kana    | string  | NOT NULL           |
| birth_year_id      | integer | NOT NULL           |
| birth_month_id     | integer | NOT NULL           |
| birth_day_id       | integer | NOT NULL           |



## Association
- has_many :items
- has_many :orders

## items table

| Column             |  Type     |  Option                    |
|-------------------------------------------------------------|
| product_name       | string    | NOT NULL                   |
| product_description| text      | NOT NULL                   |
| category_id        | integer   | NOT NULL                   |
| condition_id       | integer   | NOT NULL                   |
| shipping_fee_id    | integer   | NOT NULL                   |
| shipping_area_id   | integer   | NOT NULL                   |
| days_to_ship_id    | integer   | NOT NULL                   |
| price              | string    | NOT NULL                   |
| seller_id          |references | NOT NULL,foreign_key: true |

## Association
- belongs_to :users
- has_one :orders

## orders table

| Column           | Type      | NOT NULL                   |
|-----------------------------------------------------------|
| item_id          | references| NOT NULL,foreign_key: true |
| buyer_id         | references| NOT NULL,foreign_key: true |

## Association
- belongs_to :users
- belongs_to :items
- has_one :shippings

## Shippings table

|     Column         |  Type    |      Option                |
|------------------------------------------------------------|
| postcode          | string    | NOT NULL                   |
| prefecture_id     | integer   | NOT NULL                   |
| city              | string    | NOT NULL                   |
| block             | string    | NOT NULL                   |
| building          | string    | NOT NULL                   |
| phone_number      | string    | NOT NULL                   |
| orders_id         | references| NOT NULL,foreign_key: true |


## Association
- belongs_to :orders