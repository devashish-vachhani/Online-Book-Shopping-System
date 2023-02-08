class Book < ApplicationRecord
  validates :name, :author, :publisher, :price, :stock, presence: true
end
