class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_one :shopping_cart

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :authentication_keys => [:username]

  validates :username, :email, :name, presence: true
  validates :password, :password_confirmation, presence: true, on: :create
  validates :username, :email, uniqueness: true
  validates :phone_number, length: { is: 10 }
  validates :credit_card_number, length: { is: 16 }
end
