class Admin < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :authentication_keys => [:username]

  validates :email, :name, presence: true
  validates :username, :password, :password_confirmation, presence: true, on: :create

end
