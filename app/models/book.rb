class Book < ApplicationRecord
  has_many :reviews
  validates :name, :author, :publisher, :price, :stock, presence: true
end
