## users table

|     Column         |  Type   |      Option          |
|-----------------------------------------------------|
| nickname           | string  | NOT NULL             |
| email              | string  | NOT NULL,unique:true |
| encrypted_password | string  | NOT NULL             |
| last_name          | string  | NOT NULL             |
| first_name         | string  | NOT NULL             |
| last_name_kana     | string  | NOT NULL             |
| first_name_kana    | string  | NOT NULL             |
| birth_day          | date    | NOT NULL             |



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
| prefecture_id      | integer   | NOT NULL                   |
| days_to_ship_id    | integer   | NOT NULL                   |
| price              | integer   | NOT NULL                   |
| user               |references | NOT NULL,foreign_key: true |

## Association
- belongs_to :user
- has_one :order

## orders table

| Column           | Type      | NOT NULL                   |
|-----------------------------------------------------------|
| item             | references| NOT NULL,foreign_key: true |
| user             | references| NOT NULL,foreign_key: true |

## Association
- belongs_to :user
- belongs_to :item
- has_one :shipping

## Shippings table

|     Column         |  Type    |      Option                |
|------------------------------------------------------------|
| postcode          | string    | NOT NULL                   |
| prefecture_id     | integer   | NOT NULL                   |
| city              | string    |                            |
| block             | string    |                            |
| building          | string    |                            |
| phone_number      | string    | NOT NULL                   |
| order             | references| NOT NULL,foreign_key: true |


## Association
- belongs_to :order