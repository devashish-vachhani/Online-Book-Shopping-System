require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    let(:book) { create(:book) }

    it 'is valid with valid attributes' do
      expect(book).to be_valid
    end
    it 'is not valid without a name' do
      book.name = nil
      expect(book).not_to be_valid
    end
    it 'is not valid without an author' do
      book.author = nil
      expect(book).not_to be_valid
    end
    it 'is not valid without a publisher' do
      book.publisher = nil
      expect(book).not_to be_valid
    end
    it 'is not valid without a price' do
      book.price = nil
      expect(book).not_to be_valid
    end
    it 'is not valid without a stock' do
      book.stock = nil
      expect(book).not_to be_valid
    end
  end

  describe 'associations' do
    it { should have_many(:reviews).dependent(:destroy) }
    it { should have_many(:transactions).dependent(:nullify) }
    it { should have_many(:shopping_cart_items).dependent(:destroy) }
  end

  describe 'methods' do
    let(:book) { create(:book) }
    it 'returns the average rating of the book reviews' do
      create(:review, book: book, rating: 3)
      create(:review, book: book, rating: 5)
      expect(book.average_rating).to eq(4)
    end
  end
end