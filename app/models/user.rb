class User < ApplicationRecord
  has_many :transactions
  has_many :reviews

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :authentication_keys => [:username]

  validates :username, :email, :name, presence: true
  validates :password, :password_confirmation, presence: true, on: :create
  validates :username, :email, uniqueness: true
end
